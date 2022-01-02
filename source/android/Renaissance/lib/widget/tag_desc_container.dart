import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/my_colors.dart';

class TagDescContainer extends StatefulWidget {
  TagDescContainer({Key? key, this.tag}) : super(key: key);
  var tag;
  @override
  State<TagDescContainer> createState() => _TagDescContainerState();
}

class _TagDescContainerState extends State<TagDescContainer> {
  late var isFav = widget.tag.isFav;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.amberAccent,
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
        LimitedBox(
          maxWidth: 150,
          child: Text(
            widget.tag.description!,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ]),
    );
  }
}
