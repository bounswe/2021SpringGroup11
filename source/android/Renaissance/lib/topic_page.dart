import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:portakal/file_converter.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/comment_box.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/widget/profile_stats_widget.dart';
import 'package:portakal/widget/profile_follow_widget.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portakal/widget/milestone_widget.dart';
import 'package:flutter_spinbox/material.dart'; // or flutter_spinbox.dart for both
import 'package:portakal/models/topic_model.dart';
import 'package:portakal/models/milestone_model.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/basic_path.dart';

class TopicPage extends StatefulWidget {
  final Tag? t;
  final List<Tag>? tags;
  final List<BasicPath>? paths;
  const TopicPage({Key? key, this.t,this.tags,this.paths}) : super(key: key);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  bool isLoading = false;


  bool isFavChanged = false;
  bool isEnrollChanged = false;
  late var isFollowed = widget.t!.isFav!;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF70A9FF),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Container(
                            margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),

                                Text(
                                  widget.t!.name!,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                              ],
                            )),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0x99FFFFFF),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Topic Description',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // adding margin
                              height: 75,
                              child: SingleChildScrollView(
                                // for Vertical scrolling
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  widget.t!.description!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      height: 1.2,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    if (!isFollowed) {
                                      try {
                                        var response = await HttpService.shared
                                            .favoriteTopic(int.parse(widget.t!.id!));
                                        if (!response) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              'An error occured please try again later.',
                                              style: TextStyle(
                                                  decorationColor:
                                                  Colors.greenAccent,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ));
                                          return;
                                        }
                                      } on Exception catch (error) {}
                                    } else {
                                      try {
                                        var response = await HttpService.shared
                                            .unfavoriteTopic(int.parse(widget.t!.id!));
                                        if (!response) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              'An error occured please try again later.',
                                              style: TextStyle(
                                                  decorationColor:
                                                  Colors.greenAccent,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ));
                                          return;
                                        }
                                      } on Exception catch (error) {}
                                    }
                                    setState(() {
                                      isFollowed = !isFollowed;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      // NEW from here...
                                      isFollowed
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFollowed ? Colors.red : null,
                                      semanticLabel: isFollowed
                                          ? 'Remove from saved'
                                          : 'Save',
                                    ),
                                  )),
                              SizedBox(width: 5),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: TabBar(
                      tabs: [
                        Tab(text: 'Related Topics'),
                        Tab(text: 'Related Paths'),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      ListView(physics: BouncingScrollPhysics(), children: [
                        ...(widget.tags!)
                            .map((item) {
                          return TagContainer(tag:item);
                        }).toList()
                      ]),
                      ListView(physics: BouncingScrollPhysics(), children: [
                        ...(widget.paths!)
                            .map((item) {
                          return CourseContainer(path:item);
                        }).toList()
                      ])
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
