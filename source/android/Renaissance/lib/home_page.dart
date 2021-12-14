import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/tag.dart';

import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:portakal/widget/tag_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var tags = [
      {
        "name": "Popular",
        "tags": [
          Tag(name: "Earth", id: "1", description: "earaarrrth", isFav: true),
          Tag(name: "Sun", id: "11", description: "orbital", isFav: true),
          Tag(name: "Space", id: "21", description: "moth into the space", isFav: false),
          Tag(name: "Software", id: "31", description: "engineering.", isFav: true),
        ]
      },
      {
        "name": "For You",
        "tags": [
          Tag(name: "Games", id: "2", description: "playing some", isFav: false),
          Tag(name: "Music", id: "211", description: "guitar and piano", isFav: false),
          Tag(name: "Nature", id: "22", description: "trees flowers", isFav: false),
          Tag(name: "Food", id: "23", description: "kebab", isFav: true),
        ]
      },
      {
        "name": "New",
        "tags": [
          Tag(name: "Youtube", id: "4", description: "video platform", isFav: true),
          Tag(name: "Streaming", id: "4", description: "twitch platform", isFav: false),
          Tag(name: "Art", id: "4", description: "sculpture", isFav: true),
          Tag(name: "Gaming", id: "4", description: "minecraft", isFav: true),
        ]
      },
    ];
    var paths = [
      {
        "name": "Popular",
        "paths": [
          BasicPath(id: "123", title: "Learn Music Theory With a Shadowing Technique", effort: 10, rating: 5, photo: ""),
          BasicPath(id: "124", title: "TEDTALKS Quantum Physics Essentials", effort: 7, rating: 8, photo: ""),
          BasicPath(id: "125", title: "Become a Master Chef in a Month.", effort: 3, rating: 8.4, photo: ""),
          BasicPath(id: "125", title: "Radio and Television Design", effort: 6, rating: 8.4, photo: ""),
          BasicPath(id: "41", title: "Running a 42 km Marathon.", effort: 5.5, rating: 9.6, photo: ""),
          BasicPath(id: "471", title: "Script Writing and Planning the Main Storyline for Dummies.", effort: 7.5, rating: 8, photo: "")
        ]
      },
      {
        "name": "For You",
        "paths": [
          BasicPath(id: "130", title: "TEDTALKS Quantum Physics Essentials", effort: 7, rating: 8, photo: ""),
          BasicPath(id: "120", title: "Understanding Kafka, a detailed Author Review", effort: 1, rating: 3.8, photo: ""),
          BasicPath(id: "1244", title: "How to Survive in an Island by Yourself", effort: 6, rating: 5, photo: ""),
          BasicPath(id: "1247", title: "Explore the Marvel Cinematic Universe with All Details", effort: 2, rating: 2, photo: ""),
          BasicPath(id: "199", title: "Principles of Successful Dating", effort: 0.8, rating: 10.0, photo: ""),
        ]
      },
      {
        "name": "New",
        "paths": [
          BasicPath(id: "8593", title: "Studying and Coding with Pomodoro Technique", effort: 7.1, rating: 9.0, photo: ""),
          BasicPath(id: "8693", title: "Learn Japanese Daily Phrases.", effort: 8.4, rating: 9.2, photo: ""),
          BasicPath(id: "8793", title: "Learn to play Violin", effort: 2.9, rating: 9.3, photo: ""),
          BasicPath(id: "8893", title: "How to tie a strong knot", effort: 2.2, rating: 8.5, photo: ""),
        ]
      },
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.blue,
          leading: Image(
            image: AssetImage('assets/logoOnly.png'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Container(
            height: 40,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: Center(
              child: TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Find something',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none
                ),
              ),
            ),
          )
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          CupertinoSegmentedControl(
              children: {
                0: Text("POPULAR"),
                1: Text("FOR YOU"),
                2: Text("NEW")
              },
              onValueChanged: (value) {
                setState(() {
                  _pageIndex = value as int;
                });
              },
            padding: EdgeInsets.all(5),
            groupValue: _pageIndex,
            selectedColor: Colors.red,
            borderColor: Colors.black,
          ),
          Container(
            child: Text("TAGS", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: 2.0)),
            color: Colors.grey.shade300,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey.shade500,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...(tags[_pageIndex]["tags"] as List<Tag>)
                      .map((tag) {
                    return TagContainer(key:Key(tag.id!),tag:tag);
                  }).toList(),
                ],
              ),
            ),
          ),
          Container(
            child: Text("PATHS", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: 2.0)),
            color: Colors.grey.shade300,
          ),
          ...(paths[_pageIndex]["paths"] as List<BasicPath>)
              .map((path) {
            return CourseContainer(key: Key(path.id!),path:path);
          }).toList(),
        ],
      ),
    );
  }
}
