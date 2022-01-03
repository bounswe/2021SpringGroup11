import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/widget/activity_container.dart';

import 'my_colors.dart';

class ActivityStreamPage extends StatefulWidget {
  const ActivityStreamPage({Key? key}) : super(key: key);

  @override
  _ActivityStreamPageState createState() => _ActivityStreamPageState();
}

class _ActivityStreamPageState extends State<ActivityStreamPage> {
  Future<List<BasicPath>> get() async {
    return await HttpService.shared.myPaths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.blue,
          title: Text("Activity Stream"),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<BasicPath>>(
            future: get(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    BasicPath path = snapshot.data![index];
                    return ActivityContainer(summary: summary);
                  },
                );
              }
            },
          ),
        ));
  }
}
