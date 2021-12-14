import 'package:flutter/material.dart';
import 'package:portakal/my_colors.dart';

class StatsWidget extends StatelessWidget {
  StatsWidget(this.favourite_count,this.enrolled_course_count,this.done_course_count);
  final int favourite_count;
  final int done_course_count;
  final int enrolled_course_count;
  //final int follower_count;
  //final int following_count;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: MyColors.lightGrey,
        borderRadius: BorderRadius.circular(50)
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButton(context, favourite_count.toString(), 'Favourites'),
          buildButton(context, enrolled_course_count.toString(), 'Enrolled'),
          buildButton(context, done_course_count.toString(), 'Done'),

      ]
  )
  );




  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 2),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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