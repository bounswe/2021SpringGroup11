import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portakal/edit_profile.dart';
import 'package:portakal/file_converter.dart';
import 'package:portakal/follow_page.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/path.dart';
import 'dart:io';
import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/profile_appbar_widget.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/widget/profile_stats_widget.dart';
import 'package:portakal/widget/profile_follow_widget.dart';
import 'package:portakal/widget/course_container.dart';

import 'models/basic_path.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({ Key? key, required this.user }): super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
bool isFollowed = true;

class _ProfilePageState extends State<ProfilePage> with EditProfileDelegate, FollowerWidgetDelegate {
  late Future<List<BasicPath>> favPaths = HttpService.shared.getFavouritePaths(widget.user.username!);
  late Future<List<BasicPath>> enrolledPaths = HttpService.shared.getEnrolledPaths(widget.user.username!);

  bool loadingImage = false;
  File? profileImg;

  void loadPhoto() async {
    if (widget.user.photo == null || widget.user.photo == "") { return ; }
    setState(() {
      loadingImage = true;
    });
    profileImg = await FileConverter.getImageFromBase64(widget.user.photo!);
    setState(() {
      loadingImage = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (!loadingImage && profileImg == null) {
      loadPhoto();
    }
    return Scaffold(
      appBar: buildAppBar(context, widget.user.username!, this),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF70A9FF),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        User.me!.photo == null || User.me!.photo == "" ?
                        CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(widget.user.username![0].toUpperCase()),
                            radius: 32
                        ) : loadingImage ? CircularProgressIndicator() : ClipRRect(
                          child: Image.file(profileImg!, width: 64, height: 64, fit: BoxFit.fitHeight,),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        StatsWidget(widget.user.followed_paths ?? 0, widget.user.enrolls ?? 0, widget.user.finishedResourceCount!)
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(onPressed: _pullRefresh, child: Text("Refresh", style: TextStyle(color: Colors.white60),), color: Colors.black54, ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: 315,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0x99FFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             'About',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // adding margin
                              height: 53,
                              child: SingleChildScrollView(
                                // for Vertical scrolling
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  User.me!.bio ?? "No info yet.",
                                  style: TextStyle(fontSize: 14, height: 1.2,  fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            padding: new EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            decoration: BoxDecoration(
                                color: Color(0x99FFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(50.0))
                            ),
                            child: Center(
                                child: FollowerWidget(widget.user.follower, widget.user.following, this)
                            ),
                            margin: EdgeInsets.only(top: 10)
                        ),
                        if (User.me!.username! != widget.user.username)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              onPrimary: Colors.white,
                            ),
                            child: Text(isFollowed?"Follow":"Unfollow"),
                            onPressed: () async {
                              if (isFollowed) {
                                try {
                                  var response = await HttpService.shared.unfollowUser(User.me!.username!, widget.user.username!);
                                } on Exception catch (error) {

                                }
                              } else {
                                try {
                                  var response = await HttpService.shared.followUser(User.me!.username!, widget.user.username!);
                                } on Exception catch (error) {

                                }
                              }
                              setState(() {
                                isFollowed = !isFollowed;
                                widget.user.follower += isFollowed ? -1 : 1;
                              });
                            },
                          ),
                      ]
                  ),
                ],
              )
          ),
          InkWell(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Favourite Paths',
                    style: TextStyle(fontSize: 14,decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
              ),
              onTap: () {},
          ),
          FutureBuilder<List<BasicPath>>(
            future: favPaths,
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical:0,horizontal:10),
                    child: Text('No Favourite Paths Yet.',
                        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic))
                );
              } else {
                return Container(
                  height: 80.0,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: snapshot.data!.map((e) { e.isFollowed = true; return CourseContainer(key: Key(e.id), path: e,); }
                      ).toList(),
                    ),
                  ),
                );
              }
            }
          ),
          InkWell(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Enrolled Paths',
                    style: TextStyle(fontSize: 14,decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
              ),
              onTap: () {}
          ),

          FutureBuilder<List<BasicPath>>(
              future: enrolledPaths,
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical:0,horizontal:10),
                      child: Text('No Enrolled Paths Yet.',
                          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic))
                  );
                } else {
                  return Container(
                    height: 80.0,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: snapshot.data!.map((e) => CourseContainer(key: Key(e.id), path: e,)).toList(),
                      ),
                    ),
                  );
                }
              }
          )
        ],
      ),
    );
  }

  Future<void> _pullRefresh() async {
    User user = await HttpService.shared.getUser(widget.user.username!);
    Future<List<BasicPath>> favPaths = HttpService.shared.getFavouritePaths(widget.user.username!);
    Future<List<BasicPath>> enrolledPaths = HttpService.shared.getEnrolledPaths(widget.user.username!);
    setState(() {
      widget.user = user;
      this.favPaths = HttpService.shared.getFavouritePaths(widget.user.username!);
      this.enrolledPaths = HttpService.shared.getEnrolledPaths(widget.user.username!);
    });
  }
  @override
  void onSuccessfulSave() async {
    loadPhoto();
    setState(() {
    });
  }

  @override
  void onFollowersTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FollowerPage()));
  }

  @override
  void onFollowingsTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FollowingPage()));
  }
}

