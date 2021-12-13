import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/comment_box.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/widget/profile_stats_widget.dart';
import 'package:portakal/widget/profile_follow_widget.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portakal/widget/milestone_widget.dart';
import 'package:flutter_spinbox/material.dart'; // or flutter_spinbox.dart for both

class PathPage extends StatefulWidget {
  const PathPage({ Key? key}): super(key: key);

  @override
  _PathPageState createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
  final _controller = TextEditingController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  bool isFollowed = true;

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
            child: Image(
                image: NetworkImage('https://i.ebayimg.com/images/g/X5cAAMXQ-alQ4ZyI/s-l300.jpg'),
                width: MediaQuery.of(context).size.width * 0.4),
          ),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child:
                        Column(
                          children: [
                            Text(
                              'Learning Kanji in Two Weeks',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5,),
                            Text(
                                'Creator: Chloe Thing',
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
                                ButtonTheme(
                                  height: 20.0,
                                  buttonColor: Colors.orange,
                                  child: RaisedButton(
                                    shape: StadiumBorder(),
                                    onPressed: () {print('a');},
                                    child: Text("Writing"),
                                  ),
                                ),
                                ButtonTheme(
                                  height: 20.0,
                                  buttonColor: Colors.orange,
                                  child: RaisedButton(
                                    shape: StadiumBorder(),
                                    onPressed: () {print('b');},
                                    child: Text("Writing"),
                                  ),
                                )
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
                                  '''Hello, this path about something like that.''',
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
                            child: Text(isFollowed?"Enroll":"Unenroll"),
                            onPressed: (){
                              setState(() {
                                isFollowed = !isFollowed;
                              });
                            },
                          ),
                          Row(
                            children: [
                              InkWell(

                                  onTap: () {
                                    setState(() {
                                      isFollowed = !isFollowed;
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
                                      isFollowed ? Icons.favorite : Icons.favorite_border,
                                      color: isFollowed ? Colors.red : null,
                                      semanticLabel: isFollowed ? 'Remove from saved' : 'Save',
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
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.all(15),child:Text('Favorited: 1231',)),
                                                Container(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                                    child:SpinBox(
                                                  min: 1.0,
                                                  max: 10.0,
                                                  value: 5.0,
                                                      decimals: 1,
                                                      step: 0.1,
                                                  onChanged: (value) => print(value),
                                                )),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3,15),
                                                    shape: StadiumBorder(),
                                                    onPrimary: Colors.white,
                                                  ),
                                                  child: Text('Rate'),
                                                  onPressed: (){
                                                  },
                                                ),
                                                Container(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                                    child:SpinBox(
                                                      min: 1.0,
                                                      max: 10.0,
                                                      value: 5.0,
                                                      decimals: 1,
                                                      step: 0.1,
                                                      onChanged: (value) => print(value),
                                                    )),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3,15),
                                                    shape: StadiumBorder(),
                                                    onPrimary: Colors.white,
                                                  ),
                                                  child: Text('Rate'),
                                                  onPressed: (){
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
     MilestoneContainer('This is a title','This is a very long description',true),
      MilestoneContainer('This is a title','This is a very long description \n selam',false),
      MilestoneContainer('This is a title','This is a very long description \n selam',false),
      MilestoneContainer('This is a title','This is a very long description \n selam',false),
      MilestoneContainer('This is a title','This is a very lahkjdhjkadhjksadhjkasdhsajkdhasjkdhjkashdksdhkasdhong description \n selam',false),


    ]),
                  SizedBox(height:500,child: TestMe())

                ],
              ),
            ),
          )),



        ],
      ),
    );
  }
}

