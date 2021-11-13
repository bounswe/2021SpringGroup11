import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:portakal/models/login_response.dart';
import 'package:portakal/token.dart';

class HttpService {
  String baseUrl = "http://35.209.23.51"; // write server ip / url here
  static HttpService shared = HttpService();
  String? token = Token.shared.token;
  late Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };

  Future<LoginResponse> login(String username, String password) async {
    // only JWT strings return from this endpoint.
    String url = baseUrl + "/authentication/login/";
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
    String url = baseUrl + '/authentication/register/';
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

  Future<bool> forgotPassword(String username) async {
    String url = baseUrl + '/authentication/forgot-password/';
    Response res = await post(
      Uri.parse(url),
      body: jsonEncode({
        'username': username
      })
    );
    if (res.statusCode == 202) {
      return true;
    }
    return false;
  }

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