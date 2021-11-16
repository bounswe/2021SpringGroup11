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
          {"name": "Games", "effort": 3, "rating": 3.2},
          {"name": "Science", "effort": 7, "rating": 4.3},
          {"name": "Music", "effort": 6, "rating": 4.4},
          {"name": "Cooking", "effort": 4, "rating": 3.4},
        ]
      },
      {
        "name": "For You",
        "tags": [
          {"name": "Science", "effort": 7, "rating": 4.3},
          {"name": "Games", "effort": 3, "rating": 3.2},
          {"name": "Music", "effort": 6, "rating": 4.4},
          {"name": "Nature", "effort": 3, "rating": 4.9},
          {"name": "Movie", "effort": 6, "rating": 4.4},
        ]
      },
      {
        "name": "New",
        "tags": [
          {"name": "E-Sports", "effort": 3, "rating": 3.8},
          {"name": "Streaming", "effort": 6, "rating": 2.8},
          {"name": "Space", "effort": 4, "rating": 2.9},
          {"name": "Youtube", "effort": 6, "rating": 2.8},
          {"name": "Art", "effort": 4, "rating": 2.9},
        ]
      },
    ];
    var paths = [
      {
        "name": "Popular",
        "paths": [
          {
            "name": "Learn Music Theory With a Shadowing Technique",
            "effort": 2,
            "rating": 1.8,
            "url":
                "https://www.mrmaglocci.com/uploads/5/9/2/0/59208011/__9801869_orig.jpg"
          },
          {
            "name": "TEDTALKS Quantum Physics Essentials",
            "effort": 7,
            "rating": 4.8,
            "url":
                "https://img-cdn.tnwcdn.com/image?fit=1280%2C720&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2021%2F06%2Fschrodingers-cat.jpg&signature=0a120f4487449152b88aefd7df6035e4"
          },
          {
            "name": "Become a Master Chef in a Month.",
            "effort": 6,
            "rating": 3.9,
            "url":
                "https://m.media-amazon.com/images/S/assets.wholefoodsmarket.com//content/97/06/b8e9829749c587b37d175a282e33/7-tips-for-cooking-seafood-hero.jpg"
          },
          {
            "name": "Running a 42 km Marathon.",
            "effort": 7,
            "rating": 3.2,
            "url": "https://wmimg.azureedge.net/public/img/home/hp-4-min.jpg"
          },
          {
            "name":
                "Script Writing and Planning the Main Storyline for Dummies.",
            "effort": 3,
            "rating": 4.9,
            "url":
                "https://images.ctfassets.net/3s5io6mnxfqz/4FgiJwJPwtk1i8HzoGcC4F/7cd4e2b9312a58ba3f385e9f02bd6338/AdobeStock_112096736.jpeg?fm=jpg&w=900&fl=progressive"
          },
        ]
      },
      {
        "name": "For You",
        "paths": [
          {
            "name": "TEDTALKS Quantum Physics Essentials",
            "effort": 7,
            "rating": 4.8,
            "url":
                "https://img-cdn.tnwcdn.com/image?fit=1280%2C720&url=https%3A%2F%2Fcdn0.tnwcdn.com%2Fwp-content%2Fblogs.dir%2F1%2Ffiles%2F2021%2F06%2Fschrodingers-cat.jpg&signature=0a120f4487449152b88aefd7df6035e4"
          },
          {
            "name": "Understanding Kafka, a detailed Author Review",
            "effort": 7,
            "rating": 4.8,
            "url":
                "https://miro.medium.com/max/1100/1*E3aOnbVbUuYEFnW2NkIJIw.jpeg"
          },
          {
            "name": "How to Survive in an Island by Yourself ",
            "effort": 6,
            "rating": 3.9,
            "url":
                "http://cdn.cnn.com/cnnnext/dam/assets/180219103122-zanzibar-and-its-islands---mnemba-a-view-from-the-sky-mnemba-island-lodge.jpg"
          },
          {
            "name": "Explore the Marvel Cinematic Universe with All Details",
            "effort": 2,
            "rating": 1.8,
            "url":
                "https://play-lh.googleusercontent.com/c4SxEDCnHLh78ihzLqM3XwdCvrwJKQdhd5opSCMerITWeom5cO0yP3AKolYpqxPzIlo"
          },
        ]
      },
      {
        "name": "New",
        "paths": [
          {
            "name": "Studying and Coding with Pomodoro Technique",
            "effort": 2,
            "rating": 1.8,
            "url":
                "https://assets-global.website-files.com/6104304f085fddea384acd87/612825f61e6a8ca5c0020935_pomodoro-technique.png"
          },
          {
            "name": "The Art of Flying for People, For Real! ",
            "effort": 7,
            "rating": 4.8,
            "url":
                "https://media.istockphoto.com/photos/superman-style-enthusiasm-concept-strong-bearded-businessman-felt-a-picture-id1023747070?k=20&m=1023747070&s=612x612&w=0&h=EzLsVJ0sIqTGcpF3PQk0zb-PcywI6ZFYFzRG_xchw5k="
          },
          {
            "name": "Learn Japanese Daily Phrases.",
            "effort": 6,
            "rating": 3.9,
            "url": "https://i.ebayimg.com/images/g/X5cAAMXQ-alQ4ZyI/s-l300.jpg"
          },
          {
            "name": "Learn to play Violin",
            "effort": 2,
            "rating": 1.8,
            "url":
                "https://i.guim.co.uk/img/media/b0cc3b05df4b50ec6a46402a0ee9338cbfab3ec6/0_1039_4798_2875/master/4798.jpg?width=1200&quality=85&auto=format&fit=max&s=3404250f319dacb93b9b4d40f699064f"
          },
          {
            "name": "How to tie a strong knot",
            "effort": 7,
            "rating": 4.8,
            "url":
                "https://image.shutterstock.com/image-photo/rope-knot-isolated-on-white-260nw-310989119.jpg"
          },
          {
            "name": "Cooking for Students, Practical Receipes",
            "effort": 6,
            "rating": 3.9,
            "url":
                "https://www.seriouseats.com/thmb/GSqpVkulyUZu-D6sPijmbFV_f4s=/1500x1125/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2020__03__20200224-carretteira-pasta-vicky-wasik-21-ffe68515b25f4b348cbde845a59d6a62.jpg"
          },
          {
            "name": "How to Develop an Application in 4 months.",
            "effort": 6,
            "rating": 3.9,
            "url":
                "https://sharpsheets.io/blog/wp-content/uploads/2021/10/mobile-app-development-guide-scaled-1.jpeg"
          },
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
          ...(paths[_pageIndex]["paths"] as List<Map<String, Object>>)
              .map((path) {
            return CourseContainer(
                path["name"] as String,
                path["effort"] as int,
                path["rating"] as double,
                path["url"] as String);
          }).toList(),
        ],
      ),
    );
  }
}
