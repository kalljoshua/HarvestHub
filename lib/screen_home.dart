import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/Service/Auth.service.dart';
import 'package:todo_list/screen_AddTodo.dart';
import 'package:todo_list/screen_signin.dart';
import 'package:todo_list/screen_todocard.dart';
import 'package:todo_list/view_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthClass authClass = AuthClass();
  late Stream<QuerySnapshot> _stream;

  List<Select> selected = [];

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    _stream = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("todos")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB76E79),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodo()),
          );
        },
        backgroundColor: const Color(0xFF8F3B48),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 143, 59, 72)));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> document =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  IconData? iconData;
                  Color? iconColor;
                  switch (document["task type"]) {
                    case "Important":
                      iconData = Icons.priority_high;
                      iconColor = Colors.red;
                      break;
                    case "Planned":
                      iconData = Icons.event;
                      iconColor = Colors.amber;
                      break;
                    case "Work":
                      iconData = Icons.work;
                      iconColor = Colors.blueGrey;
                      break;
                    case "Shopping":
                      iconData = Icons.shopping_cart;
                      iconColor = Colors.indigo;
                      break;
                    case "Health":
                      iconData = Icons.run_circle;
                      iconColor = Colors.black;
                      break;
                    case "Financial":
                      iconData = Icons.money;
                      iconColor = Colors.grey;
                      break;
                    case "Travel":
                      iconData = Icons.travel_explore;
                      iconColor = Colors.green;
                      break;
                    case "Study":
                      iconData = Icons.book;
                      iconColor = Colors.orange;
                      break;
                    case "Personal":
                      iconData = Icons.face;
                      iconColor = Colors.teal;
                      break;
                  }
                  selected.add(Select(
                      id: snapshot.data!.docs[index].id, checkValue: false));
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => ViewData(
                                document: document,
                                id: snapshot.data!.docs[index].id,
                              )));
                    },
                    child: TodoCard(
                      title: document["title"] ?? "Title",
                      iconData: iconData ?? Icons.library_books,
                      iconColor:
                          iconColor ?? const Color.fromARGB(255, 143, 59, 72),
                      time: _formatTimestamp(document["timestamp"]),
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      index: index,
                      onChanged: onChanged,
                    ),
                  );
                });
          }),
    );
  }

  void onChanged(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      final dateTime = timestamp.toDate();
      final formattedTime =
          DateFormat('h:mm a').format(dateTime); // Format as desired
      return formattedTime;
    }
    return "N/A";
  }
}

Future<void> signout(BuildContext context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.clear();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signOut();
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignIn()),
      (route) => false);
}

class Select {
  late String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}
