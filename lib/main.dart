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
    MaterialColor customPrimarySwatch = const MaterialColor(0xFF8F3B48, {
      50: Color(0xFFE3B2BD),
      100: Color(0xFFD28594),
      200: Color(0xFFC45D6D),
      300: Color(0xFFB63546),
      400: Color(0xFFA81E2F),
      500: Color(0xFF8F3B48), // The primary color
      600: Color(0xFF7C2D3E),
      700: Color(0xFF672532),
      800: Color(0xFF521925),
      900: Color(0xFF3E0D19),
    });
    return MaterialApp(
      theme: ThemeData(primarySwatch: customPrimarySwatch),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
