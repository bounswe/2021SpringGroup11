import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:portakal/bottom_navigation_page.dart';
import 'package:portakal/home_page.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'models/login_response.dart';
import 'register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  if (isLoggedIn) {
    var token = await Token.shared.initializeToken();
    User.me = await HttpService.shared.getUser(Jwt.parseJwt(token!)['username']);
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: isLoggedIn ? "/home" : "/",
    routes: {
      "/": (context) => const LoginPage(),
      "/home": (context) => const BottomNavigationPage(),
    },
  ));
}
