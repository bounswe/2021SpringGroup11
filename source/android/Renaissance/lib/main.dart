import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portakal/home_page.dart';
import 'login_page.dart';
import 'register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.lightBlue[800]
      ),
      home: LoginPage(),
    );
  }
}