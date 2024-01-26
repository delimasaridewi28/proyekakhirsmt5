// main.dart
import 'package:flutter/material.dart';
import 'screens/film_list.dart';
import 'screens/login.dart';

void main() {
  runApp(LoginApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film Terbaru',
      theme: ThemeData(
        primaryColor: Color(0xFFF2A531),
        scaffoldBackgroundColor: Color(0xFFF2A531),
      ),
      home: Scaffold(
        body: SafeArea(
          child: FilmList(),
        ),
      ),
    );
  }
}
