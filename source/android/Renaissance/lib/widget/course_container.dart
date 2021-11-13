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
          margin: EdgeInsets.all(5),
          color: Colors.transparent,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                children: [
                  Text(course_name,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Effort",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.yellow)),
                          const SizedBox(height: 1),
                          Text(course_effort.toString(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white))
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          Text("Rating",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.yellow)),
                          const SizedBox(height: 1),
                          Text(course_rating.toString(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  MaterialButton(
                    shape: StadiumBorder(),
                    color: MyColors.lightGrey,
                    padding: EdgeInsets.symmetric(vertical: 2),
                    onPressed: () {
                      print("Selam");
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Follow",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}