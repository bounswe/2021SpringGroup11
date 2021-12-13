
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/widget/course_container.dart';

import 'my_colors.dart';

class MyPathsPage extends StatefulWidget {
  const MyPathsPage({Key? key}): super(key: key);

  @override
  _MyPathsPageState createState() => _MyPathsPageState();
}

class _MyPathsPageState extends State<MyPathsPage> {
  late Future<List<BasicPath>> myPaths;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //myPaths = [] as Future<List<BasicPath>>;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue,
        title: Text("My Paths"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<BasicPath>>(
          future: myPaths,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  BasicPath path = snapshot.data![index];
                  return CourseContainer(path);
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