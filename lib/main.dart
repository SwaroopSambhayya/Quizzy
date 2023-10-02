import 'package:flutter/material.dart';
import 'package:quiz/core/theme/theme.dart';
import 'package:quiz/features/categories/categories.dart';
import 'package:quiz/features/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzy',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      home: const Quizzy(),
    );
  }
}

class Quizzy extends StatefulWidget {
  const Quizzy({super.key});

  @override
  State<Quizzy> createState() => _QuizzyState();
}

class _QuizzyState extends State<Quizzy> {
  SharedPreferences? preferences;
  @override
  void initState() {
    getUserStatus();
    super.initState();
  }

  getUserStatus() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return preferences?.getStringList('user') != null
        ? const SelectCategory()
        : const SignUp();
  }
}
