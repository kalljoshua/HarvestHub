import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'hidden_drawer.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String formatDateOnlyDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String type = "";
  String selectedDateText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB76E79),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 143, 59, 72),
      //   title: const Center(
      //     child: Text('Create Todo'),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFFB76E79),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HidddenDrawer()),
                            (route) => false);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                textItem('Task Title'),
                const SizedBox(
                  height: 30,
                ),
                description(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 22,
                    ),
                    showDate(),
                    IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_month),
                      iconSize: 30,
                      color: const Color.fromARGB(255, 114, 44, 54),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(width: 40),
                        const Text(
                          "Task Type:",
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFF0BBC3)),
                        ),
                        const SizedBox(width: 20),
                        chip('Important'),
                        const SizedBox(width: 20),
                        chip('Planned'),
                        const SizedBox(width: 20),
                        chip('Work'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 80),
                        const SizedBox(width: 20),
                        chip('Shopping'),
                        const SizedBox(width: 20),
                        chip('Health'),
                        const SizedBox(width: 20),
                        chip('Financial'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 80),
                        const SizedBox(width: 20),
                        chip('Travel'),
                        const SizedBox(width: 20),
                        chip('Study'),
                        const SizedBox(width: 20),
                        chip('Personal'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textItem(String labeltext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: _titleController,
        cursorColor: const Color.fromARGB(255, 143, 59, 72),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: const TextStyle(fontSize: 17, color: Color(0xFFF0BBC3)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 143, 59, 72),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xFFF0BBC3),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial selected date
      firstDate: DateTime(2000), // Earliest selectable date
      lastDate: DateTime(2101), // Latest selectable date
    );
    if (picked != null) {
      setState(() {
        selectedDateText = formatDateOnlyDate(picked);
      });
    }
  }

  Widget description() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: _descriptionController,
        cursorColor: const Color.fromARGB(255, 143, 59, 72),
        maxLines: null,
        decoration: InputDecoration(
          labelText: 'Description',
          labelStyle: const TextStyle(fontSize: 17, color: Color(0xFFF0BBC3)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 143, 59, 72),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xFFF0BBC3),
            ),
          ),
          // contentPadding: const EdgeInsets.symmetric(vertical: 150)
        ),
      ),
    );
  }

  Widget chip(String label) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: type == label
            ? const Color.fromARGB(255, 143, 59, 72)
            : const Color(0xFFB76E79),
      ),
    );
  }

  Widget showDate() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      height: 55,
      child: TextFormField(
        controller: TextEditingController(
            text: selectedDateText), // Display selected date
        cursorColor: const Color.fromARGB(255, 143, 59, 72),
        decoration: InputDecoration(
          labelText: 'Date',
          labelStyle: const TextStyle(fontSize: 17, color: Color(0xFFF0BBC3)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 143, 59, 72),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xFFF0BBC3),
            ),
          ),
        ),
        onTap: () => _selectDate(context), // Show date picker when tapped
      ),
    );
  }

  Widget button() {
    final currentUserId = FirebaseAuth.instance.currentUser;
    return InkWell(
      onTap: () async {
        if (currentUserId != null) {
          final todoData = {
            "title": _titleController.text,
            "description": _descriptionController.text,
            "date": selectedDateText,
            "task type": type,
            "timestamp": FieldValue.serverTimestamp(),
          };
          final userTodosRef = FirebaseFirestore.instance
              .collection("users")
              .doc(currentUserId.uid)
              .collection("todos");
          final newTodoRef = await userTodosRef.add(todoData);
          // ignore: unused_local_variable
          String newTodoId = newTodoRef.id;
          _titleController.clear();
          _descriptionController.clear();
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const HidddenDrawer()));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 114, 44, 54)),
        child: const Center(
          child: Text(
            'Add Todo',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
