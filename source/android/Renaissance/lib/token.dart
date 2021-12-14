import 'package:portakal/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static Token shared = Token();
  String? token;
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = value;
    HttpService.shared.token = token;
    return prefs.setString('token', value);
  }

  Future<String?> initializeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    HttpService.shared.token = token;
    return token;
  }
}