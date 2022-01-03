import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/my_colors.dart';

class TagSearchContainer extends StatefulWidget {
  TagSearchContainer({Key? key, this.tag}) : super(key: key);
  var tag;
  @override
  State<TagSearchContainer> createState() => _TagSearchContainerState();
}

class _TagSearchContainerState extends State<TagSearchContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          // tag t = await HttpService.shared.getTopic(widget.tag.id);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => TopicPage(tag: t)),
          // );
          print("Clicked topic");
        },
        child: Container(
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
        ));
  }
}
