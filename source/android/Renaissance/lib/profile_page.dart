import 'package:flutter/material.dart';
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

  final profilePhotoUrl = String;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [

          Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF70A9FF),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))),
                child: Column(
                  children:[
                    const SizedBox(height: 8),
                    Row(
                    children: [
                      const SizedBox(width: 4),

                      CircleAvatar(
                      backgroundImage: NetworkImage('https://thispersondoesnotexist.com/image'),
                      radius: 32
                    ),


                      const SizedBox(width: 4),

                      Container(
                        width: 285.0,
                        color: Colors.transparent,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0x99FFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(50.0))),
                            child: new Center(
                                child:         StatsWidget(72, 4, 3)

                            )
                        ),
                      ),
                    ]
          ),
                      const SizedBox(height: 2),
                      Column(
                        children: [


                          const SizedBox(height: 10),
                          Container(
                              width: 330.0,
                              color: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                decoration: BoxDecoration(
                                    color: Color(0x99FFFFFF),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(

                                      // adding margin

                                      height: 53,
                                        child: SingleChildScrollView(
                                          // for Vertical scrolling
                                          scrollDirection: Axis.vertical,
                                          child: Text(
                                            'Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Ipsum Dolor Sit Amet.Ipsum Dolor Sit AIpsum Dolor Sit Amet.Ipsum Dolor Sit Amet.Ipsum Dolor Sit Amet.Ipsum Dolor Sit Amet.met.Ipsum Dolor Sit Amet.Ipsum Dolor Sit Amet.Lorem Ipsum Dolor Sit Amet.Lorem Ipsum Dolor Sit Amet. ',
                                            style: TextStyle(fontSize: 14, height: 1.2),
                                          ),
                                      ),
                                    ),

                                  ],
                                ),
                              )
                          ),

                          const SizedBox(height: 10),
                          Row(
                              children: [
                                const SizedBox(width: 4),


                                Container(
                                  color: Colors.transparent,
                                  child: Container(
                                      padding: new EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Color(0x99FFFFFF),
                                          borderRadius: BorderRadius.all(Radius.circular(50.0))),
                                      child: new Center(
                                          child:         FollowerWidget(71,81)

                                      )
                                  ),
                                ),
                                const SizedBox(width: 20),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(120,40),
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
                          const SizedBox(height: 10),

                        ],
                      ),]
                )),
          ),
          Container(
              width: 330.0,
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                decoration: BoxDecoration(
                    color: Color(0x99FFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        child: Text('Favourite Resources',
                            style: TextStyle(fontSize: 14,decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
                        onTap: () {}
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        CourseContainer("hello hello hello hge",1,2.0),
                        const SizedBox(width: 12),
                        CourseContainer("hello hello hello hge",1,2.0),
                        const SizedBox(width: 12),
                        CourseContainer("hello hello hello hge",1,2.0)

                      ],
                    ),
                    const SizedBox(height: 18),

                    InkWell(
                        child: Text('Enrolled Resources',
                            style: TextStyle(fontSize: 14,decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
                        onTap: () {}
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        CourseContainer("hello hello hello hge",1,2.0),
                        const SizedBox(width: 12),
                        CourseContainer("hello hello hello hge",1,2.0),
                        const SizedBox(width: 12),
                        CourseContainer("hello hello hello hge",1,2.0)

                      ],
                    )
                     ],
                   )

               )
          ),


        ],
      ),
    );
  }


}

