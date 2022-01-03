import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/my_colors.dart';

class TagCreateContainer extends StatefulWidget {
  TagCreateContainer({Key? key, this.tag}) : super(key: key);
  var tag;
  @override
  State<TagCreateContainer> createState() => _TagCreateContainerState();
}

class _TagCreateContainerState extends State<TagCreateContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.lightGreen,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(children: [
        LimitedBox(
          maxWidth: 150,
          child: Text(
            widget.tag.name!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
