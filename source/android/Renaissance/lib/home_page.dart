import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  void changePage(int num) {
    setState(() {
      _pageIndex = num;
    });
  }

  @override
  Widget build(BuildContext context) {
    var tags = [
      {
        "name": "Popular",
        "tags": [
          {"name": "Pop1", "effort": 2, "rating": 1.2},
          {"name": "Pop2", "effort": 2, "rating": 1.3},
          {"name": "Pop3", "effort": 2, "rating": 1.4},
          {"name": "Pop4", "effort": 2, "rating": 1.4},
        ]
      },
      {
        "name": "For You",
        "tags": [
          {"name": "For1", "effort": 2, "rating": 1.5},
          {"name": "For2", "effort": 2, "rating": 1.6},
          {"name": "For3", "effort": 2, "rating": 1.7},
        ]
      },
      {
        "name": "New",
        "tags": [
          {"name": "New1", "effort": 2, "rating": 1.8},
          {"name": "New2", "effort": 2, "rating": 1.8},
          {"name": "New3", "effort": 2, "rating": 1.9},
        ]
      },
    ];
    var paths = [
      {"name": "LEARN MUSIC THEORY WITH A SHADOWING TECHNIQUE", "effort": 2, "rating": 1.8},
      {"name": "TEDTALKS QUANTUM PHYSICS ESSENTIALS", "effort": 7, "rating": 1.8},
      {"name": "SUCH A COOL PATH HERE.", "effort": 8, "rating": 1.9},
      // {"name": "Cam", "effort": 2, "rating": 1.5},
      // {"name": "Kar", "effort": 2, "rating": 1.6},
      // {"name": "Araba", "effort": 2, "rating": 1.7},
      // {"name": "Selam", "effort": 2, "rating": 1.8},
      // {"name": "Muz", "effort": 2, "rating": 1.8},
      // {"name": "Ahoy", "effort": 2, "rating": 1.9},
      // {"name": "Cam", "effort": 2, "rating": 1.5},
      // {"name": "Kar", "effort": 2, "rating": 1.6},
      // {"name": "Araba", "effort": 2, "rating": 1.7},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  'Popular',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(MyColors.lightYellow),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () => changePage(0),
              ),
              ElevatedButton(
                child: Text(
                  'For You',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(MyColors.lightYellow),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () => changePage(1),
              ),
              ElevatedButton(
                child: Text(
                  'New',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(MyColors.lightYellow),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () => changePage(2),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  child: Text(
                    'Tags',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(width: 3),
                      ),
                    ),
                  ),
                  onPressed: () => null,
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: Color(0x99FFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...(tags[_pageIndex]["tags"] as List<Map<String, Object>>)
                      .map((tag) {
                    return TagContainer(tag["name"] as String,
                        tag["effort"] as int, tag["rating"] as double);
                  }).toList(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  child: Text(
                    'Paths',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(width: 3),
                      ),
                    ),
                  ),
                  onPressed: () => null,
                ),
              )
            ],
          ),
          ...paths.map((path) {
            return CourseContainer(path["name"] as String,
                path["effort"] as int, path["rating"] as double);
          }).toList(),
        ],
      ),
    );
  }
}
