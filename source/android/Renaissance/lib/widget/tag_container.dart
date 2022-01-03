import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/topic_model.dart';
import 'package:portakal/my_colors.dart';

class TagContainer extends StatefulWidget {
  TagContainer({Key? key, required this.topic}): super(key:key);
  Topic topic;
  @override
  State<TagContainer> createState() => _TagContainerState();
}

class _TagContainerState extends State<TagContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.all(5),
          color: Colors.transparent,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              decoration: BoxDecoration(
                  color: MyColors.lightGreen,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.topic.name!,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14)),
                ],
              )
          ),
        )
    );
  }
}
