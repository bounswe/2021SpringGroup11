import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portakal/my_colors.dart';

class CourseContainer extends StatelessWidget {
  CourseContainer(this.course_name, this.course_effort, this.course_rating);

  final String course_name;
  final int course_effort;
  final double course_rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Course Clicked");
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent
        ),
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Row(
                children: [
                  Image(image: AssetImage('assets/logoOnly.png')),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course_name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.red)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(course_effort.toString()),
                          Text(course_rating.toString())
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 20,
              child: SizedBox(height: 10),
            )
          ],
        ),
      ),
    );
  }
}
