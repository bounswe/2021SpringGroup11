import 'package:flutter/animation.dart';
import 'package:http/http.dart';
import 'dart:convert';

class HttpService {
  String baseUrl = "localhost:8000"; // write server ip / url here
  static HttpService shared = HttpService();
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<String> login(String email, String password) async {
    String url = baseUrl + "/api/login";
    Response res = await post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'password': password
      })
    );
    String body = res.body;
    if (res.statusCode == 200) {
      return jsonDecode(body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String> register(String email, String username, String fullName, String password) async {
    String url = baseUrl + '/api/register';
    Response res = await post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'username': username,
        'fullName': fullName,
        'password': password
      })
    );
    String body = res.body;
    if (res.statusCode == 200) {
      return jsonDecode(body);
    } else {
      throw Exception('Failed to register');
    }
  }

  /*Future<String> forgotPassword(String email) async {
    String url = baseUrl + 'api/forgotPassword';

  }*/


}