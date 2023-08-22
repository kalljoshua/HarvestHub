import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/Service/Auth.service.dart';
import 'package:todo_list/screen_signin.dart';
import 'Screen_PhoneAuth.dart';
import 'hidden_drawer.dart';
import 'main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFF0BBC3),
      //   title: const Center(
      //       child:),
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFFB76E79),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SIGNUP",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonItem("assets/google.svg", "Continue with Google", 25,
                  () async {
                await authClass.googleSignIn(context);
              }),
              const SizedBox(
                height: 15,
              ),
              buttonItem("assets/phone (1).svg", "Continue with Phone", 25, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhoneAuth()),
                );
              }),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "or",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              textItem('Email', _emailcontroller, false),
              const SizedBox(
                height: 15,
              ),
              textItem('Password', _passwordcontroller, true),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: colorButton(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If you already have an Account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//Google and mobile buttons
  Widget buttonItem(
      String imagepath, String buttonName, double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: const Color(0xFFF0BBC3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              imagepath,
              height: size,
              width: size,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              buttonName,
              style: const TextStyle(fontSize: 17),
            ),
          ]),
        ),
      ),
    );
  }

//Email and PAssword Textformfield
  Widget textItem(
      String labeltext, TextEditingController controller, bool obscuretext) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscuretext,
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

  Widget colorButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
                  email: _emailcontroller.text,
                  password: _passwordcontroller.text);
          print(userCredential.user!.email);
          setState(() {
            circular = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HidddenDrawer()),
              (route) => false);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(SAVE_KEY, true);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 114, 44, 54)),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  'SignUp',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }
}
