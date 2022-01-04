import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:portakal/file_converter.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/Resource.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/topic_page.dart';
import 'package:portakal/widget/comment_box.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/widget/profile_follow_widget.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portakal/widget/milestone_widget.dart';
import 'package:flutter_spinbox/material.dart'; // or flutter_spinbox.dart for both
import 'package:portakal/models/topic_model.dart';
import 'package:portakal/models/milestone_model.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/widget/resource_container.dart';

import 'add_resource_page.dart';

import 'models/tag.dart';

class PathPage extends StatefulWidget {
  final Path? p;
  const PathPage({Key? key, this.p}) : super(key: key);

  @override
  _PathPageState createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
  bool isLoading = false;
  bool tagsAreLoading = false;
  var _image;

  void loadPhoto() async {
    if (widget.p!.photo == "") {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _image = await FileConverter.getImageFromBase64(widget.p!.photo!);
    setState(() {
      isLoading = false;
    });
  }
  bool isButtonEffortLoading = false;
  bool isButtonRateLoading = false;
  bool isButtonFinishLoading = false;

  bool isFavChanged = false;
  bool isEnrollChanged = false;
  late var isFollowed = widget.p!.isFollowed!;
  late var isEnrolled = widget.p!.isEnrolled!;
  double rating = 5.0;
  double effort = 5.0;
  final profilePhotoUrl = String;

  @override
  Widget build(BuildContext context) {
    if (!isLoading && _image == null) {
      loadPhoto();
    }
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
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: _image != null
                                ? Image.file(
                                    _image,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height:
                                        MediaQuery.of(context).size.width * 0.4,
                                    fit: BoxFit.fitHeight,
                                  )
                                : (isLoading
                                    ? CircularProgressIndicator()
                                    : CircleAvatar(
                                        backgroundColor: MyColors.red,
                                        child: Text("image"),
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                      ))),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Column(
                              children: [
                                Text(
                                  widget.p!.title,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Creator: ' + widget.p!.creator_username,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: 'Rating: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.greenAccent),
                                            children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  widget.p!.rating.toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black))
                                        ])),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Difficulty: ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.deepOrange),
                                            children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  widget.p!.effort.toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black))
                                        ])),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Tags:',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            ...(widget.p!.topics!
                                                    as List<Topic>)
                                                .map((topic) {
                                              return ButtonTheme(
                                                height: 20.0,
                                                buttonColor: Colors.orange,
                                                child: RaisedButton(
                                                  shape: StadiumBorder(),
                                                  onPressed: () async{
                                                    /*Tag temp_t= await HttpService.shared.getTopic(topic.ID!.toString());
                                                    List<Tag> list_t= await HttpService.shared.getTopicList(topic.ID!.toString());
                                                    List<BasicPath> list_p= await HttpService.shared.getPathList(topic.ID!.toString());*/
                                                    setState(() {
                                                      tagsAreLoading = true;
                                                    });
                                                    List responses = await Future.wait([HttpService.shared.getTopic(topic.ID!.toString()), HttpService.shared.getTopicList(topic.ID!.toString()),HttpService.shared.getPathList(topic.ID!.toString())]);
                                                    setState(() {
                                                      tagsAreLoading = false;
                                                    });
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => TopicPage(t:responses[0],tags:responses[1],paths: responses[2],)),
                                                    );
                                                  },
                                                  child: tagsAreLoading?SizedBox(height: 10.0,
                                                      width: 10.0,child:CircularProgressIndicator()):Text(topic.name!),
                                                ),
                                              );
                                            }).toList()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
                              'Path Description',
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
                                  widget.p!.description,
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.3, 15),
                              shape: StadiumBorder(),
                              onPrimary: Colors.white,
                            ),
                            child: Text(!isEnrolled ? "Enroll" : "Unenroll"),
                            onPressed: () async {
                              if (!isEnrolled) {
                                try {
                                  var response = await HttpService.shared
                                      .enroll(
                                          User.me!.username!, widget.p!.id);
                                  if (!response) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'An error occured please try again later.',
                                        style: TextStyle(
                                            decorationColor: Colors.greenAccent,
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
                                      .unenroll(
                                          User.me!.username!, widget.p!.id);
                                  if (!response) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'An error occured please try again later.',
                                        style: TextStyle(
                                            decorationColor: Colors.greenAccent,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                                    return;
                                  }
                                } on Exception catch (error) {}
                              }
                              setState(() {
                                isEnrolled = !isEnrolled;
                              });
                            },
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    if (!isFollowed) {
                                      try {
                                        var response = await HttpService.shared
                                            .fav_path(User.me!.username!,
                                                widget.p!.id);
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
                                            .unfav_path(User.me!.username!,
                                                widget.p!.id);
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
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(builder: (context, StateSetter setState) {
                                          return Dialog(
                                            child: Container(
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  SizedBox(height: 20),
                                                  /*Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),*/
                                                  Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 30,
                                                          vertical: 10),
                                                      child: SpinBox(
                                                          min: 1.0,
                                                          max: 10.0,
                                                          value: 5.0,
                                                          decimals: 1,
                                                          step: 0.1,
                                                          onChanged: (value) => {
                                                            setState(() {
                                                              rating = value;
                                                            })
                                                          })),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.3,
                                                          15),
                                                      shape: StadiumBorder(),
                                                      onPrimary: Colors.white,
                                                    ),
                                                    child: isButtonRateLoading?CircularProgressIndicator(color:Colors.deepOrangeAccent):Text('Rate Path'),
                                                    onPressed: () async {
                                                      try {
                                                        setState(() {
                                                          isButtonRateLoading=true;
                                                        });
                                                        var response =
                                                        await HttpService
                                                            .shared
                                                            .rate_path(
                                                            User.me!
                                                                .username!,
                                                            widget.p!.id,
                                                            rating);
                                                        setState(() {
                                                          isButtonRateLoading=false;
                                                        });
                                                        if (!response) {
                                                          ScaffoldMessenger.of(
                                                              context)
                                                              .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'An error occured please try again later.',
                                                                  style: TextStyle(
                                                                      decorationColor:
                                                                      Colors
                                                                          .greenAccent,
                                                                      fontSize: 25,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              ));
                                                          return;
                                                        }
                                                      } on Exception catch (error) {
                                                        setState(() {
                                                          isButtonRateLoading=false;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 30,
                                                          vertical: 10),
                                                      child: SpinBox(
                                                          min: 1.0,
                                                          max: 10.0,
                                                          value: 5.0,
                                                          decimals: 1,
                                                          step: 0.1,
                                                          onChanged: (value) => {
                                                            setState(() {
                                                              effort = value;
                                                            })
                                                          })),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.3,
                                                          15),
                                                      shape: StadiumBorder(),
                                                      onPrimary: Colors.white,
                                                    ),
                                                    child: isButtonEffortLoading?CircularProgressIndicator(color:Colors.deepOrangeAccent):Text('Rate Difficulty'),
                                                    onPressed: () async {
                                                      try {
                                                        setState(() {
                                                          isButtonEffortLoading=true;
                                                        });
                                                        var response =
                                                        await HttpService
                                                            .shared
                                                            .effort_path(
                                                            User.me!
                                                                .username!,
                                                            widget.p!.id,
                                                            effort);
                                                        setState(() {
                                                          isButtonEffortLoading=false;
                                                        });
                                                        if (!response) {

                                                          ScaffoldMessenger.of(
                                                              context)
                                                              .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'An error occured please try again later.',
                                                                  style: TextStyle(
                                                                      decorationColor:
                                                                      Colors
                                                                          .greenAccent,
                                                                      fontSize: 25,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              ));
                                                          return;
                                                        }
                                                      } on Exception catch (error) {
                                                        setState(() {
                                                          isButtonEffortLoading=false;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.3,
                                                          15),
                                                      shape: StadiumBorder(),
                                                      onPrimary: Colors.white,
                                                    ),
                                                    child: isButtonFinishLoading?CircularProgressIndicator(color:Colors.deepOrangeAccent):Text('Finish Path'),
                                                    onPressed: () async {
                                                      try {
                                                        setState(() {
                                                          isButtonFinishLoading=true;
                                                        });
                                                        var response =
                                                        await HttpService
                                                            .shared
                                                            .finish_path(
                                                            User.me!
                                                                .username!,
                                                            widget.p!.id
                                                        );
                                                        if (!response) {
                                                          setState(() {
                                                            isButtonFinishLoading=false;
                                                          });
                                                          ScaffoldMessenger.of(
                                                              context)
                                                              .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'An error occured please try again later.',
                                                                  style: TextStyle(
                                                                      decorationColor:
                                                                      Colors
                                                                          .greenAccent,
                                                                      fontSize: 25,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              ));
                                                          return;
                                                        }
                                                        else{
                                                          setState(() {
                                                            isButtonFinishLoading=false;
                                                          });
                                                          ScaffoldMessenger.of(
                                                              context)
                                                              .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Successfully finished',
                                                                  style: TextStyle(
                                                                      decorationColor:
                                                                      Colors
                                                                          .greenAccent,
                                                                      fontSize: 25,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              ));
                                                          return;
                                                        }
                                                      } on Exception catch (error) {
                                                        setState(() {
                                                          isButtonFinishLoading=false;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        );}

                                    );
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
                                    child: FaIcon(FontAwesomeIcons.infoCircle),
                                  )),
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
                    Tab(text: 'Tasks'),
                    Tab(text: 'Resources'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ListView(physics: BouncingScrollPhysics(), children: [
                    ...(widget.p!.milestones as List<Milestonee>)
                        .map((milestone) {
                      return MilestoneContainer(milestone.id!, milestone.title!,
                          milestone.body!, milestone.isFinished!,milestone.type!);
                    }).toList()
                  ]),
                  ListView(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          MaterialButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddResourcePage()),
                            );
                          },
                            color: MyColors.lightYellow,
                            child: Text("ADD NEW RESOURCE"),
                          ),
                          Spacer()
                        ],
                      ),
                      ResourceContainer(resource: Resource(username: "@tahsin", taskId: 10, description: "Allahi daha derinden ve yakindan tanimak icin gerekeni yapmaliyiz. Kurani Kerim Japonca meali tam da bunun icin, Link is below.", link: "hebele_hubele")),
                      ResourceContainer(resource:  Resource(username: "@muhsin", taskId: 3, description: "Bence en iyi namaz 4 rekat kilinan namazdir. Ama sureleri bilmeden olmaz. Sure kitabi linkini birakiyorum.", link: "qurani_kerim.com"),),
                      ResourceContainer(resource:  Resource(username: "@berkecan", taskId: 6, description: "Pdf dosyalarini acabilmenin sirri nedir? Cilegin serada mi tarlada mi yetistigini nasil anlariz? Ibrahim Tatlises terorist miydi?", link: "isiksu.inci"),),
                    ],
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
