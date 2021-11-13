import 'package:flutter/material.dart';

class FollowerWidget extends StatelessWidget {
  FollowerWidget(this.follower_count,this.following_count);
  final int follower_count;
  final int following_count;

  @override
  Widget build(BuildContext context) => Container(
      child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildButton(context, follower_count.toString(), 'Followers'),
            buildButton(context, following_count.toString(), 'Followings'),

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