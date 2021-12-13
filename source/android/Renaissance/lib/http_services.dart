import 'dart:async';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:http/http.dart';
import 'package:portakal/models/get_follow_response.dart';
import 'dart:convert';

import 'package:portakal/models/login_response.dart';
import 'package:portakal/models/search_result.dart';
import 'package:portakal/token.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'models/user.dart';

class HttpService {
  String baseUrl = "http://35.209.23.51"; // write server ip / url here
  String invalidToken = 'Token is not valid';
  static HttpService shared = HttpService();
  late String? token = Token.shared.token;
  late Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };

  Future<LoginResponse> login(String username, String password) async {
    // only JWT strings return from this endpoint.
    String url = baseUrl + "/authentication/login/";
    Response res = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'username': username, 'password': password}));
    if (res.statusCode == 200) {
      await Token.shared.setToken(res.body.replaceAll('"', ''));
      token = Token.shared.token;
      return LoginResponse.fromJson(Jwt.parseJwt(res.body));
    } else if (res.statusCode == 400) {
      throw Exception('No user exists for given username');
    } else if (res.statusCode == 401) {
      throw Exception('Wrong password');
    } else {
      throw Exception('UnknownError');
    }
  }

  Future<LoginResponse> refreshToken() async {
    String url = baseUrl + '/authentication/refresh-token/';
    Response res = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'jwt': token!.replaceAll('"', '')}));
    if (res.statusCode == 200) {
      await Token.shared.setToken(res.body.replaceAll('"', ''));
      token = Token.shared.token;
      return LoginResponse.fromJson(Jwt.parseJwt(res.body));
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<bool> register(String email, String username, String firstname,
      String lastname, String password) async {
    String url = baseUrl + '/authentication/signup/';
    Response res = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'email': email,
          'username': username,
          'firstname': firstname,
          'lastname': lastname,
          'password': password
        }));
    if (res.statusCode == 200) {
      return true;
    } else if (res.statusCode == 406) {
      throw Exception('User already exists with this username.');
    } else {
      throw Exception('UnknownError');
    }
  }

  Future<bool> forgotPassword(String username) async {
    String url = baseUrl + '/authentication/forgot-password/';
    Response res = await post(Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'username': username}));
    if (res.statusCode == 202) {
      return true;
    }
    return false;
  }

  Future<bool> banUser(String username) async {
    String url = baseUrl + '/authentication/ban-user/';
    Response res = await post(Uri.parse(url),
        headers: headers, body: jsonEncode({'username': username}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<User> getUser(String username) async {
    String url = baseUrl + '/user/get-profile/$username/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<User> editUser(
      String firstName, String lastName, String bio, String? photo) async {
    String url = baseUrl + '/user/edit-user/';
    var body = jsonEncode({
      'firstname': firstName,
      'lastname': lastName,
      'bio': bio,
      'photo': photo
    });
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 403) {
      //await refreshToken();
      throw Exception("403.");
    } else {
      throw Exception(headers[HttpHeaders
          .authorizationHeader]); // token not valid donuyor anlamsizca. token da set edili normalde.
    }
  }

  Future<User> changePassword(String password) async {
    String url = baseUrl + 'user/change-password/';
    var body = jsonEncode({'password': password});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<String> followUser(String username, String targetUsername) async {
    String url = baseUrl + 'user/follow-user/';
    var body = jsonEncode({'username': username, 'target': targetUsername});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception(res.body);
    }
  }

  Future<String> unfollowUser(String username, String targetUsername) async {
    String url = baseUrl + 'user/unfollow-user/';
    var body = jsonEncode({'username': username, 'target': targetUsername});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception(res.body);
    }
  }

/*
  Future<List<Object>> search(String name) async {
    return (searchUser(name).concat(searchPath(name).concat(searchUser(name))));
  }
  */

  Future<List<Object>> searchUser(String username) async {
    String url = baseUrl + '/user/search-user/$username/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
      return (jsonDecode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<List<Object>> searchPath(String pathName) async {
    String url = baseUrl + '/user/search-path/$pathName/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
      return (jsonDecode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<List<Object>> searchTag(String topicName) async {
    String url = baseUrl + '/user/search-topic/$topicName/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
      return (jsonDecode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<bool> favoriteTopic(int id) async {
    String url = baseUrl + '/topic/favorite-topic/';
    final body = jsonEncode({'username': User.me!.username, 'ID': id});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(res.body);
    }
  }

  Future<bool> unfavoriteTopic(int id) async {
    String url = baseUrl + '/topic/unfavorite-topic/';
    final body = jsonEncode({'username': User.me!.username, 'ID': id});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(res.body);
    }
  }

  Future<bool> enrollPath(String id) async {
    String url = baseUrl + '/path/enroll-path/';
    final body = jsonEncode({'username': User.me!.username, 'path_id': id});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(res.body);
    }
  }

  Future<bool> unenrollPath(String id) async {
    String url = baseUrl + '/path/unenroll-path/';
    final body = jsonEncode({'username': User.me!.username, 'path_id': id});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(res.body);
    }
  }

  Future<GetFollowResponse> getFollow(String username) async {
    String url = baseUrl + '/user/get-follow/';
    Response res = await get(Uri.parse(url), headers: headers);
    if (res.statusCode == 200) {
      return GetFollowResponse.fromJSON(json.decode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<bool> followPath(String pathId) async {
    String url = baseUrl + '/path/follow-path';
    final body =
        jsonEncode({'username': User.me!.username!, 'path_id': pathId});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(res.body);
    }
  }

  Future<bool> unfollowPath(String pathId) async {
    String url = baseUrl + '/path/unfollow-path';
    final body =
        jsonEncode({'username': User.me!.username!, 'path_id': pathId});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(res.body);
    }
  }

  // Future<bool> getFollowedPaths(String username) async {
  //   String url = baseUrl + '/path/get-followed-paths/';
  //   Response res = await get(Uri.parse(url), headers: headers);
  //
  // }
}
