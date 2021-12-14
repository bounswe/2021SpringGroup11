import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/widget/course_container.dart';

import 'my_colors.dart';

class MyPathsPage extends StatefulWidget {
  const MyPathsPage({Key? key}) : super(key: key);

  @override
  _MyPathsPageState createState() => _MyPathsPageState();
}

class _MyPathsPageState extends State<MyPathsPage> {
  Future<List<BasicPath>> get() async {
    return await HttpService.shared.myPaths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.blue,
          title: Text("My Paths"),
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
                    return CourseContainer(path: path);
                  },
                );
              }
            },
          ),
        ));
  }
}
