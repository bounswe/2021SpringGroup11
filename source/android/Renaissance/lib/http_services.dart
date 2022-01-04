import 'dart:developer';
import 'dart:async';
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:http/http.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/get_follow_response.dart';
import 'dart:convert';

import 'package:portakal/models/login_response.dart';

import 'package:portakal/models/milestone.dart';
import 'package:portakal/models/milestone_model.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/models/activity.dart';

import 'package:portakal/models/topic_model.dart';
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
    HttpHeaders.authorizationHeader: 'Bearer $token'.replaceAll('"', '')
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

  Future<bool> enroll(String username, String id) async {
    String url = baseUrl + '/path/enroll-path/';
    Response res = await post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({'username': username, 'path_id': id}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> unenroll(String username, String id) async {
    String url = baseUrl + '/path/unenroll-path/';
    Response res = await post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({'username': username, 'path_id': id}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> fav_path(String username, String id) async {
    String url = baseUrl + '/path/follow-path/';
    Response res = await post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({'username': username, 'path_id': id}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> unfav_path(String username, String id) async {
    String url = baseUrl + '/path/unfollow-path/';
    Response res = await post(Uri.parse(url),
        headers: headers,
        body: jsonEncode({'username': username, 'path_id': id}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> finish_mielstone(String id) async {
    String url = baseUrl + '/path/finish-milestone/';
    Response res = await post(Uri.parse(url),
        headers: headers, body: jsonEncode({'milestone_id': id}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> unfinish_milestone(String id) async {
    String url = baseUrl + '/path/unfinish-milestone/';
    Response res = await post(Uri.parse(url),
        headers: headers, body: jsonEncode({'milestone_id': id}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> rate_path(String username, String id, double value) async {
    String url = baseUrl + '/path/rate-path/';
    Response res = await post(Uri.parse(url),
        headers: headers,
        body:
            jsonEncode({'username': username, 'path_id': id, 'rating': value}));
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> effort_path(String username, String id, double value) async {
    String url = baseUrl + '/path/effort-path/';
    Response res = await post(Uri.parse(url),
        headers: headers,
        body:
            jsonEncode({'username': username, 'path_id': id, 'effort': value}));
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

  Future<Path> getPath(String path_id) async {
    String url = baseUrl + '/path/get-path/$path_id/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      var temp = jsonDecode(res.body);
      List<Milestonee> milestoness = [];
      List<Topic> topicss = [];

      (temp["milestones"]).map((tag) {
        milestoness.add(Milestonee.fromJson(tag));
      }).toList();

      (temp["topics"]).map((tag) {
        topicss.add(Topic.fromJson(tag));
      }).toList();
      return Path(
          id: path_id,
          title: temp['title'],
          description: temp['description'],
          topics: topicss,
          creator_username: temp['creator_username'],
          creator_email: temp['creator_email'],
          created_at: 1.0 * temp['created_at'],
          photo: temp['photo'],
          milestones: milestoness,
          rating: temp['rating'],
          effort: temp['effort'],
          isEnrolled: temp['isEnrolled'],
          isFollowed: temp['isFollowed']);
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
    String url = baseUrl + '/user/change-password/';
    var body = jsonEncode({'password': password});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<String> followUser(String username, String targetUsername) async {
    String url = baseUrl + '/user/follow-user/';
    var body = jsonEncode({'username': username, 'target': targetUsername});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception(res.body);
    }
  }

  Future<String> unfollowUser(String username, String targetUsername) async {
    String url = baseUrl + '/user/unfollow-user/';
    var body = jsonEncode({'username': username, 'target': targetUsername});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception(res.body);
    }
  }

  Future<User> createPath(
      String title,
      String description,
      List<Map<String, String>> milestones,
      String? photo,
      List<Map<String, Object>> topics) async {
    String url = baseUrl + '/path/create-path/';
    var body = jsonEncode({
      'title': title,
      'description': description,
      'milestones': milestones,
      'topics': topics,
      'photo': photo,
    });
    //log(body);
    log(HttpHeaders.authorizationHeader);
    print(body);
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 403) {
      //await refreshToken();
      throw Exception("Please try again later.");
    } else {
      throw Exception("An Error Occured. Please try again later.");
    }
  }
/*
  Future<List<Object>> search(String name) async {
    return (searchUser(name).concat(searchPath(name).concat(searchUser(name))));
  }
  */

  Future<List<String>> searchUser(String username) async {
    String url = baseUrl + '/user/search-user/$username/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      List<String> result = [];
      for (var item in jsonDecode(res.body)) {
        result.add(item["username"]);
      }
      return result;
    } else {
      throw Exception(res.body);
    }
  }

  Future<List<Object>> searchPath(String pathName) async {
    String url = baseUrl + '/path/search-path/$pathName/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      return (jsonDecode(res.body));
    } else {
      throw Exception(res.body);
    }
  }

  Future<List<Tag>> searchTopic(String topicName) async {
    String url = baseUrl + '/topic/search-topic/$topicName/';
    Response res = await get(Uri.parse(url), headers: headers);

    if (res.statusCode == 200) {
      List<Tag> result = [];
      for (var item in jsonDecode(res.body)) {
        result.add(Tag.fromJSON(item));
      }
      return (result);
    } else {
      throw Exception("An error occured with topics, please try another set");
    }
  }

  Future<List<Activity>> activityStream() async {
    String url = baseUrl + '/user/activity-streams/';

    Response res = await post(Uri.parse(url), headers: headers);
    if (res.statusCode == 200) {
      List<Activity> result = [];
      for (var item in jsonDecode(res.body)) {
        result.add(Activity.fromJSON(item));
      }
      return (result);
    } else {
      throw Exception("An error occured with topics, please try another set");
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
    String url = baseUrl + '/path/follow-path/';
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
    String url = baseUrl + '/path/unfollow-path/';
    final body =
        jsonEncode({'username': User.me!.username!, 'path_id': pathId});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(res.body);
    }
  }

  Future<List<BasicPath>> getFollowedPaths(String username) async {
    String url = baseUrl + '/path/get-followed-paths/';
    final body = jsonEncode({'username': username});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<BasicPath> basicPaths =
          l.map((json) => BasicPath.fromJSON(json)).toList();
      return basicPaths;
    } else {
      throw Exception(res.body);
    }
  }

  Future<List<BasicPath>> getEnrolledPaths(String username) async {
    String url = baseUrl + '/path/get-enrolled-paths/';
    final body = jsonEncode({'username': username});
    Response res = await post(Uri.parse(url), headers: headers, body: body);
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<BasicPath> basicPaths =
          l.map((json) => BasicPath.fromJSON(json)).toList();
      return basicPaths;
    } else {
      throw Exception(res.body);
    }
  }

  Future<List<BasicPath>> myPaths() async {
    String url = baseUrl + '/path/my-paths/';
    Response res = await get(Uri.parse(url), headers: headers);
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<BasicPath> basicPaths =
          l.map((json) => BasicPath.fromJSON(json)).toList();
      return basicPaths;
    } else {
      throw Exception(res.body);
    }
  }
}
