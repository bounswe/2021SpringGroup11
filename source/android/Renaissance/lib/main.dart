import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portakal/bottom_navigation_page.dart';
import 'package:portakal/home_page.dart';
import 'package:portakal/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  if (isLoggedIn) {
    Token.shared.initializeToken();
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLoggedIn ? BottomNavigationPage() : LoginPage(), // MUST BE SET TO HOMEPAGE IF LOGGED IN.
  ));
}