
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/widget/course_container.dart';

import 'my_colors.dart';

class MyPathsPage extends StatefulWidget {
  const MyPathsPage({Key? key}): super(key: key);

  @override
  _MyPathsPageState createState() => _MyPathsPageState();
}

class _MyPathsPageState extends State<MyPathsPage> {
  late Future<List<Path>> myPaths;

  @override
  void initState() {
    super.initState();
    myPaths = HttpService.shared.myPaths();
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
        child: FutureBuilder<List<Path>>(
          future: myPaths,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Path path = snapshot.data![index];
                  return CourseContainer(path.basic());
                },
              );
            } else {
              return Container();
            }
          },
        ),
      )
    );
  }
}