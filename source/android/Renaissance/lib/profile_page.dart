import 'package:flutter/material.dart';
import 'package:portakal/widget/profile_appbar_widget.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/widget/profile_stats_widget.dart';
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
                    children: [CircleAvatar(
                      backgroundImage: NetworkImage('https://thispersondoesnotexist.com/image'),
                      radius: 32,
                    ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
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
                      const SizedBox(height: 2),
                      Column(
                        children: [
                          Text('JohnDoe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white)),
                          const SizedBox(height: 4),
                          Container(
                            height: 25.0,
                            width: 175.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0x99FFFFFF),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: new Center(
                                  child: new Text('GRANDMASTER',
                                    style: TextStyle(fontSize: 20, color: Color(0xFFEB5757)),
                                    textAlign: TextAlign.center,),
                                )
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 330.0,
                            color: Colors.transparent,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0x99FFFFFF),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                                child: new Center(
                                    child:         StatsWidget(72, 4, 3, 151, 80)

                                )
                            ),
                          ),
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
                                    const SizedBox(height: 8),
                                    Text(
                                      'Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. Lorem Ipsum Dolor Sit Amet. ',
                                      style: TextStyle(fontSize: 14, height: 1.4),
                                    ),
                                  ],
                                ),
                              )
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
                    MaterialButton(
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(vertical: 2),
                      onPressed: () {},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                          Text(
                            "Resource1",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color:Color(0xFF219653)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Deneme",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Color(0xFF828282)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),


        ],
      ),
    );
  }


}

