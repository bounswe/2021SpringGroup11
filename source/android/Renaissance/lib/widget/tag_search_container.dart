import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/topic_page.dart';

class TagSearchContainer extends StatefulWidget {
  TagSearchContainer({Key? key, this.tag}) : super(key: key);
  Tag? tag;
  @override
  State<TagSearchContainer> createState() => _TagSearchContainerState();
}

class _TagSearchContainerState extends State<TagSearchContainer> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          List responses = await Future.wait([HttpService.shared.getTopic(widget.tag!.id!), HttpService.shared.getTopicList(widget.tag!.id!),HttpService.shared.getPathList(widget.tag!.id!)]);
          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TopicPage(t:responses[0],tags:responses[1],paths: responses[2],)),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: isLoading?SizedBox(height:30,width:30,child:CircularProgressIndicator()):Column(children: [
            LimitedBox(
              maxWidth: 150,
              child: Text(
                widget.tag!.name!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            LimitedBox(
              maxWidth: 150,
              child: Text(
                widget.tag!.description??"",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ]),
        ));
  }
}
