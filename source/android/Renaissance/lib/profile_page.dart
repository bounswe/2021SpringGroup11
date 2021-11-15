import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/profile_appbar_widget.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/widget/profile_stats_widget.dart';
import 'package:portakal/widget/profile_follow_widget.dart';
import 'package:portakal/widget/course_container.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({ Key? key, required this.user }): super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
bool isFollowed = true;

class _ProfilePageState extends State<ProfilePage> {

  var paths = [
    {"name": "Selam", "effort": 2, "rating": 10.0},
    {"name": "Muz", "effort": 2, "rating": 10.0},
    {"name": "Ahoy", "effort": 2, "rating": 10.0},
    {"name": "Cam", "effort": 2, "rating": 10.0},
    {"name": "Kar", "effort": 2, "rating": 11.0},
    {"name": "Araba", "effort": 2, "rating": 10.0},
    {"name": "Selam", "effort": 2, "rating": 10.0},
    {"name": "Muz", "effort": 2, "rating": 10.0},
    {"name": "Ahoy", "effort": 2, "rating": 11.0},
    {"name": "Cam", "effort": 2, "rating": 1.0},
    {"name": "Kar", "effort": 2, "rating": 10.0},
    {"name": "Araba", "effort": 2, "rating": 10.0},
  ];
  final profilePhotoUrl = String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
                        CircleAvatar(
                            backgroundImage: NetworkImage('https://thispersondoesnotexist.com/image'),
                            radius: 32
                        ),
                        StatsWidget(72, 40, 59)
                      ]
                  ),
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
                              '''Merhaba ben Renaissance kullaniyorum... Yalnizca acil aramalar. Yazilim muhendisi. Blogger. Kabul etmiyoruz vazgecmiyoruz. :))''',
                              style: TextStyle(fontSize: 14, height: 1.2),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            child: new Center(
                                child: FollowerWidget(71,81)
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
                            onPressed: (){
                              setState(() {
                                isFollowed = !isFollowed;
                              });
                            },
                          ),
                      ]
                  ),
                ],
              )
          ),
          InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Favourite Resources',
                    style: TextStyle(fontSize: 14,decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
              ),
              onTap: () {},
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                paths.map((path) {
                  return CourseContainer(path["name"] as String,
                      path["effort"] as int, path["rating"] as double);
                }).toList(),
            ),
          ),
          InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Enrolled Resources',
                    style: TextStyle(fontSize: 14,decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
              ),
              onTap: () {}
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CourseContainer("hello hello hello hge",1,2.0),
                CourseContainer("hello hello hello hge",1,2.0),
                CourseContainer("hello hello hello hge",1,2.0)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

