import 'package:flutter/animation.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:portakal/models/login_response.dart';

class HttpService {
  String baseUrl = "localhost:8000"; // write server ip / url here
  static HttpService shared = HttpService();
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<LoginResponse> login(String username, String password) async {
    String url = baseUrl + "/authentication/login";
    Response res = await post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'username': username,
        'password': password
      })
    );
    if (res.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(res.body));
    } else if (res.statusCode == 400) {
      throw Exception('Banned user');
    } else if (res.statusCode == 401) {
      throw Exception('Wrong password');
    } else {
      throw Exception('UnknownError');
    }
  }

  Future<bool> register(String email, String username, String firstname, String lastname, String password) async {
    String url = baseUrl + '/authentication/register';
    Response res = await post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'password': password
      })
    );
    if (res.statusCode == 200) {
      return true;
    } else if(res.statusCode == 406) {
      throw Exception('User already exists with this username or password.');
    } else {
      throw Exception('UnknownError');
    }
  }

  /*Future<String> forgotPassword(String email) async {
    String url = baseUrl + 'api/forgotPassword';

  }*/

 /* Future<String> refreshToken() async {
    String url = baseUrl + '/authentication/refresh-token';

    Response res = await post(
        Uri.parse(url),
        headers: headers,
    );

  } */

  Future<bool> banUser(String username) async {
    String url = baseUrl + '/authentication/ban-user';
    Response res = await post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'username': username
      })
    );

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

}