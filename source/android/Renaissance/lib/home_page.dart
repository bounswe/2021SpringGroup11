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
          {"name": "Topics", "effort": 3, "rating": 3.2},
          {"name": "Science", "effort": 7, "rating": 4.3},
          {"name": "Music", "effort": 6, "rating": 4.4},
          {"name": "Cooking", "effort": 4, "rating": 3.4},
        ]
      },
      {
        "name": "For You",
        "tags": [
          {"name": "Science", "effort": 7, "rating": 4.3},
          {"name": "Topics", "effort": 3, "rating": 3.2},
          {"name": "Music", "effort": 6, "rating": 4.4},
      ]
      },
      {
        "name": "New",
        "tags": [
          {"name": "E-Sports", "effort": 3, "rating": 3.8},
          {"name": "Streaming", "effort": 6, "rating": 2.8},
          {"name": "Space", "effort": 4, "rating": 2.9},
        ]
      },
    ];
    var paths = [
      {"name": "Learn Music Theory With a Shadowing Technique", "effort": 2, "rating": 1.8,"url":"https://www.mrmaglocci.com/uploads/5/9/2/0/59208011/__9801869_orig.jpg"},
      {"name": "TEDTALKS Quantum Physics Essentials", "effort": 7, "rating": 4.8, "url":"https://img-cdn.tnwcdn.com/image?fit=1280%2C720&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2021%2F06%2Fschrodingers-cat.jpg&signature=0a120f4487449152b88aefd7df6035e4"},
      {"name": "Become a Master Chef in a Month.", "effort": 6, "rating": 3.9,"url":"https://m.media-amazon.com/images/S/assets.wholefoodsmarket.com//content/97/06/b8e9829749c587b37d175a282e33/7-tips-for-cooking-seafood-hero.jpg"},
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
                path["effort"] as int, path["rating"] as double,path["url"] as String);
          }).toList(),
        ],
      ),
    );
  }
}
