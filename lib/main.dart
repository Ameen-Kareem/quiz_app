import 'package:flutter/material.dart';
import 'package:test_4/view/options_screen/options_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OptionsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
