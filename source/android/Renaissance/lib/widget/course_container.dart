import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portakal/file_converter.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/path_page.dart';

class CourseContainer extends StatefulWidget {
  CourseContainer({Key? key, required this.path}):super(key:key);

  final BasicPath path;

  @override
  State<CourseContainer> createState() => _CourseContainerState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CourseContainerState extends State<CourseContainer> {
  bool already_saved = false, isLoading = false;
  var _image;

  void loadPhoto() async {
    if (widget.path.photo == "") {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _image = await FileConverter.getImageFromBase64(widget.path.photo!);
    setState(() {
      isLoading = false;
    });
  }
  bool isButtonLoading = false;
  @override
  Widget build(BuildContext context) {
    if(!isLoading && _image == null) {
      loadPhoto();
    }
    already_saved = widget.path.isFollowed ?? false;
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
              onTap: () async{
                setState(() {
                  isButtonLoading = true;
                });
                Path p= await HttpService.shared.getPath(widget.path.id!);
                setState(() {
                  isButtonLoading = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PathPage(p:p)),
                );

              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: MyColors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: isButtonLoading?CircularProgressIndicator(color: Colors.deepOrangeAccent,):Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: _image != null ? Image.file(_image, width: 60, height: 60, fit: BoxFit.fitHeight,) :
                      (isLoading ? CircularProgressIndicator() :
                      CircleAvatar(backgroundColor: MyColors.red, child: Text("image"), radius: 30,)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(widget.path.title,
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
                                  Text(widget.path.effort.toString(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ]),
                                Column(children: [
                                  Text('Rating',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.yellow)),
                                  Text(widget.path.rating.toString(),
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
                setState(() {
                  already_saved = !already_saved;
                });
                if (already_saved) {
                  HttpService.shared.followPath(widget.path.id);
                } else {
                  HttpService.shared.unfollowPath(widget.path.id);
                }
              },
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                    color: MyColors.blue,
                    borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                child: Icon(
                  // NEW from here...
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
