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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: MyColors.blue,
              leading: Image(
                image: AssetImage('assets/logoOnly.png'),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(42),
                ),
              ),
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
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
                        border: InputBorder.none),
                  ),
                ),
              )),
          body: ListView(physics: BouncingScrollPhysics(), children: [
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
                  onPressed: () => null,
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
                  onPressed: () => null,
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
                  onPressed: () => null,
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
            ]),
            Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0x99FFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 6),
                            TagContainer("hello", 1, 2.0),
                            const SizedBox(width: 12),
                            TagContainer("hello ", 1, 2.0),
                            const SizedBox(width: 12),
                            TagContainer(" hge", 1, 2.0)
                          ],
                        ),
                        const SizedBox(height: 18),
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: BorderSide(width: 3)),
                                    ),
                                  ),
                                  onPressed: () => null,
                                ),
                              )
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 6),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0)
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 6),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0)
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 6),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0)
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 6),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0),
                            const SizedBox(width: 12),
                            CourseContainer("hello hello hello hge", 1, 2.0)
                          ],
                        ),
                      ],
                    ))),
          ])),
    );
  }
}
