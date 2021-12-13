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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portakal/widget/milestone_widget.dart';
import 'package:flutter_spinbox/material.dart'; // or flutter_spinbox.dart for both
import 'package:portakal/models/topic_model.dart';
import 'package:portakal/models/milestone_model.dart';

class PathPage extends StatefulWidget {
  final String? ID;
  final String? title;
  final String? description;
  final List<Topic>? topics;
  final String? creator_username;
  final String? creator_email;
  final int? created_at;
  final String? photo;
  final List<Milestone>? milestones;
  final bool? is_banned;
  final bool? is_deleted;
  final bool? isFollowed;
  final bool? isEnrolled;
  const PathPage({ Key? key, this.ID,this.title,this.description,this.topics,this.creator_username,this.creator_email,this.created_at,this.photo,this.milestones,this.is_banned,this.is_deleted,this.isFollowed,this.isEnrolled}): super(key: key);

  @override
  _PathPageState createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
  bool isLoading = false;
  var _image;

  void loadPhoto() async {
    if (widget.photo == "") {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _image = await FileConverter.getImageFromBase64(widget.photo!);
    setState(() {
      isLoading = false;
    });
  }


  bool isFavChanged = false;
  bool isEnrollChanged = false;
  bool isFollowed = false;
  bool isEnrolled=false;
  double rating = 5.0;
  double effort = 5.0;
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
      backgroundColor: Colors.blue,
      body: Column(
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
                  SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: _image != null ? Image.file(_image, width: MediaQuery.of(context).size.width * 0.4, height: MediaQuery.of(context).size.width * 0.4, fit: BoxFit.fitHeight,) :
                            (isLoading ? CircularProgressIndicator() :
                            CircleAvatar(backgroundColor: MyColors.red, child: Text("image"), radius: MediaQuery.of(context).size.width * 0.2,))
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child:
                        Column(
                          children: [
                            Text(
                              widget.title!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5,),
                            Text(
                                'Creator: '+widget.creator_username!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15,color:Colors.white),
                            ),
                            SizedBox(height: 15,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RichText(text:TextSpan( text:'Rating: ',
                                    style: TextStyle(fontSize: 14,color:Colors.greenAccent),
                                    children: <TextSpan>[
                                      TextSpan( text:'8.1',
                                          style: TextStyle(fontSize: 14,color:Colors.black))
                                    ])),
                                RichText(text:TextSpan( text:'Effort: ',
                                  style: TextStyle(fontSize: 14,color:Colors.deepOrange),
                                children: <TextSpan>[
                                    TextSpan( text:'75%',
                                    style: TextStyle(fontSize: 14,color:Colors.black))
                                ])),
                              ],
                            ),
                            SizedBox(height: 10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Tags:',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:Colors.white),
                                ),
                          SizedBox(width:MediaQuery.of(context).size.width * 0.3,child:SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...(widget.topics! as List<Topic>)
                                    .map((topic) {
                                  return  ButtonTheme(
                                    height: 20.0,
                                    buttonColor: Colors.orange,
                                    child: RaisedButton(
                                      shape: StadiumBorder(),
                                      onPressed: () {print(topic.ID);},
                                      child: Text(topic.name!),
                                    ),
                                  );
                                }).toList()

                              ],
                            ),
                          ),),

                              ],
                            ),
                          ],
                        )
                        ),
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0x99FFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Path Description',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // adding margin
                              height: 75,
                              child: SingleChildScrollView(
                                // for Vertical scrolling
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  widget.description!,
                                  style: TextStyle(fontSize: 14, height: 1.2,  fontStyle: FontStyle.italic),
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
                              fixedSize: Size(MediaQuery.of(context).size.width * 0.3,15),
                              shape: StadiumBorder(),
                              onPrimary: Colors.white,
                            ),
                            child: Text((isEnrollChanged?isEnrolled:widget.isEnrolled!)?"Enroll":"Unenroll"),
                            onPressed: () async{
                              if ((isEnrollChanged?isEnrolled:widget.isEnrolled!)) {
                                try {
                                  var response = await HttpService.shared.enroll(User.me!.username!, widget.ID!);
                                } on Exception catch (error) {

                                }
                              } else {
                                try {
                                  var response = await HttpService.shared.unenroll(User.me!.username!, widget.ID!);
                                } on Exception catch (error) {
                                }
                              }
                              setState(() {
                                if(!isEnrollChanged){
                                  isEnrollChanged = true;
                                  isEnrolled = !widget.isEnrolled!;
                                }
                                else{
                                  isEnrollChanged = !isEnrollChanged;
                                }
                              });
                            },
                          ),
                          Row(
                            children: [
                              InkWell(

                                  onTap: () async{
                                    if ((isFavChanged?isFollowed:widget.isFollowed!)) {
                                      try {
                                        var response = await HttpService.shared.fav_path(User.me!.username!, widget.ID!);
                                      } on Exception catch (error) {

                                      }
                                    } else {
                                      try {
                                        var response = await HttpService.shared.unfav_path(User.me!.username!, widget.ID!);
                                      } on Exception catch (error) {
                                      }
                                    }
                                    setState(() {

                                      if(!isFavChanged){
                                        isFavChanged = true;
                                        isFollowed = !widget.isFollowed!;
                                      }
                                      else{
                                        isFavChanged = !isFavChanged;
                                        isFollowed = !isFollowed;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      // NEW from here...
                                      (isFavChanged?isFollowed:widget.isFollowed!) ? Icons.favorite : Icons.favorite_border,
                                      color: (isFavChanged?isFollowed:widget.isFollowed!) ? Colors.red : null,
                                      semanticLabel: (isFavChanged?isFollowed:widget.isFollowed!) ? 'Remove from saved' : 'Save',
                                    ),
                                  )),
                              SizedBox(width:5),
                              InkWell(

                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => Dialog(
                                        child:  Container(

                                          child:
                                            ListView(
                                              shrinkWrap: true,
                                              children: [
                                                SizedBox(height: 20),
                                                /*Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),*/
                                                Container(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                                    child:SpinBox(
                                                  min: 1.0,
                                                  max: 10.0,
                                                  value: 5.0,
                                                      decimals: 1,
                                                      step: 0.1,
                                                  onChanged: (value) => {

                                                setState(() {
                                                  rating = value;
                                                })}
                                                )
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3,15),
                                                    shape: StadiumBorder(),
                                                    onPrimary: Colors.white,
                                                  ),
                                                  child: Text('Rate Path'),
                                                  onPressed: ()async{
                                                    try {
                                                      var response = await HttpService.shared.rate_path(User.me!.username!, widget.ID!,rating);
                                                    } on Exception catch (error) {
                                                    }
                                                  },
                                                ),
                                                Container(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                                    child:SpinBox(
                                                      min: 1.0,
                                                      max: 10.0,
                                                      value: 5.0,
                                                      decimals: 1,
                                                      step: 0.1,
                                                        onChanged: (value) => {

                                                          setState(() {
                                                            effort = value;
                                                          })}
                                                    )),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3,15),
                                                    shape: StadiumBorder(),
                                                    onPrimary: Colors.white,
                                                  ),
                                                  child: Text('Rate Effort'),
                                                  onPressed: ()async{
                                                    try {
                                                      var response = await HttpService.shared.effort_path(User.me!.username!, widget.ID!,effort);
                                                    } on Exception catch (error) {
                                                    }
                                                  },
                                                ),



                                              ],
                                            ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15)),
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
              )
          ),
          Expanded(child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: TabBar(
                  tabs: [
                    Tab(text: 'Milestones'),
                    Tab(text: 'Comments'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
              ListView(
                physics: BouncingScrollPhysics(),
    children: [
      ...(widget.milestones! as List<Milestone>)
          .map((milestone) {
        return   MilestoneContainer(milestone.id!,milestone.title!,milestone.body!,milestone.isFinished!);
      }).toList()


    ]),
                  Text("Under Development.")
                ],
              ),
            ),
          )),



        ],
      ),
    );
  }
}

