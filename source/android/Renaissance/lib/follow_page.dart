
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/get_follow_response.dart';

import 'models/user.dart';
import 'my_colors.dart';

class FollowerPage extends StatelessWidget {
  late Future<GetFollowResponse> follows = HttpService.shared.getFollow(User.me!.username!);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue,
        title: Text("Followers List"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<GetFollowResponse>(
          future: follows,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.followers!.length,
                itemBuilder: (context, index) {
                  String username = snapshot.data!.followers![index];
                  return Text(username);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class FollowingPage extends StatelessWidget {
  late Future<GetFollowResponse> follows = HttpService.shared.getFollow(User.me!.username!);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue,
        title: Text("Followings List"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<GetFollowResponse>(
          future: follows,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.followed!.length,
                itemBuilder: (context, index) {
                  String username = snapshot.data!.followed![index];
                  return Text(username);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}