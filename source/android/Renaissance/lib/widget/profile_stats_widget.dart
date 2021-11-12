import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  StatsWidget(this.favourite_count,this.enrolled_course_count,this.done_course_count,this.follower_count,this.following_count);
  final int favourite_count;
  final int done_course_count;
  final int enrolled_course_count;
  final int follower_count;
  final int following_count;

  @override
  Widget build(BuildContext context) => Column(
      children:[Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, favourite_count.toString(), 'Favourites'),
          buildButton(context, enrolled_course_count.toString(), 'Enrolled'),
          buildButton(context, done_course_count.toString(), 'Done'),


        ],
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, done_course_count.toString(), 'Followers'),
            buildButton(context, done_course_count.toString(), 'Followings'),


          ],
        )
      ]
  );




  Widget buildButton(BuildContext context, String value, String text) =>
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
              text,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color:Color(0xFF219653)),
            ),
            SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Color(0xFF828282)),
            ),
          ],
        ),
      );
}