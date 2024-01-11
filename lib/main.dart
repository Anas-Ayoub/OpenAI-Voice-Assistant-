import 'package:openai/Themes/dark_theme.dart';
import 'package:openai/Themes/light_theme.dart';
import 'package:openai/home_page.dart';
import 'package:openai/pallete.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'openai',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomePage(),
    );
  }
}
