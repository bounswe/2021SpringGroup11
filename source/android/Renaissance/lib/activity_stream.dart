import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/widget/activity_container.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:io';

import 'models/activity.dart';
import 'my_colors.dart';

class ActivityStreamPage extends StatefulWidget {
  const ActivityStreamPage({Key? key}) : super(key: key);

  @override
  _ActivityStreamPageState createState() => _ActivityStreamPageState();
}
bool isLoading = true;
class _ActivityStreamPageState extends State<ActivityStreamPage> {
  var _activites = [];

  void get() async {
    List<Activity> temp = await HttpService.shared.activityStream();
    setState(() {
      _activites = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    get();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.blue,
          title: Text("Activity Stream"),
          centerTitle: true,
        ),
        body: Center(
                child: _activites.length==0?CircularProgressIndicator():
                ListView(physics: BouncingScrollPhysics(), children: [
                  ...(_activites)
                      .map((item) {
                    return ActivityContainer(item.summary!,item.time!);
                  }).toList()
                ]),

        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          setState(() {
            _activites = [];
          });
          get();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
