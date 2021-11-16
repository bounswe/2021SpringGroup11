import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portakal/my_colors.dart';


class CourseContainer extends StatefulWidget {
  CourseContainer(this.course_name, this.course_effort, this.course_rating);

  final String course_name;
  final int course_effort;
  final double course_rating;

  @override
  State<CourseContainer> createState() => _CourseContainerState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CourseContainerState extends State<CourseContainer> {
  bool already_saved = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.transparent),
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                print("Course Clicked");
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(color: Colors.green.shade300),
                child: Row(
                  children: [
                    Image(
                        image: AssetImage('assets/logoOnly.png'),
                        width: MediaQuery.of(context).size.width * 0.2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(widget.course_name,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(children: [
                                  Text('Effort',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.yellow)),
                                  Text(widget.course_effort.toString(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ]),
                                Column(children: [
                                  Text('Rating',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.yellow)),
                                  Text(widget.course_rating.toString(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white))
                                ])
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              )),
          Container(
            width: MediaQuery.of(context).size.width * 0.02,
            child: SizedBox(height: 10),
          ),
          InkWell(
              onTap: () {
                already_saved = !already_saved;
              },
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(color: Colors.green.shade300),
                alignment: Alignment.center,
                child:  Icon(   // NEW from here...
                  already_saved ? Icons.favorite : Icons.favorite_border,
                  color: already_saved ? Colors.red : null,
                  semanticLabel: already_saved ? 'Remove from saved' : 'Save',
                ),
              )),
        ],
      ),
    );
  }
}
