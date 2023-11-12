import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/screen_signin.dart';
import 'hidden_drawer.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    IsLoggedIn(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6DC45D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/splash_screen.gif'),
          ),
          // const SizedBox(height: 20),
          // const Text(
          //   "TODO LIST",
          //   style: TextStyle(color: Color(0xFFB76E79), fontSize: 35),
          // ),
        ],
      ),
    );
  }
}

Future<void> gotoLogin(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 3));
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: ((context) => const SignIn())));
}

// ignore: non_constant_identifier_names
Future<void> IsLoggedIn(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final islogged = prefs.getBool(SAVE_KEY);
  if (islogged == null || islogged == false) {
    // ignore: use_build_context_synchronously
    gotoLogin(context);
  } else {
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const HidddenDrawer())));
  }
}
