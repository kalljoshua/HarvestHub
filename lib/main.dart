import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_list/screen_splash.dart';

const SAVE_KEY = '_islogged';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    MaterialColor customPrimarySwatch = const MaterialColor(0xFF4B8F3B, {
      50: Color(0xFFB2E3B2),
      100: Color(0xFF94D285),
      200: Color(0xFF6DC45D),
      300: Color(0xFF46B635),
      400: Color(0xFF2FA81E),
      500: Color(0xFF4B8F3B), // The primary color
      600: Color(0xFF3E7C2D),
      700: Color(0xFF326725),
      800: Color(0xFF255219),
      900: Color(0xFF193E0D),
    });
    return MaterialApp(
      theme: ThemeData(primarySwatch: customPrimarySwatch),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
