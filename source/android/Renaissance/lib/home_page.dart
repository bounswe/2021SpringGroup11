import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/home_page_response.dart';
import 'package:portakal/models/search_result.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/tag.dart';

import 'package:portakal/my_colors.dart';
import 'package:portakal/search_page.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:portakal/widget/tag_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pageIndex = 0;
  HomePageResponse _results = HomePageResponse(paths: [], topics: []);
  var _isLoading = false;
  void _fetchPopular() async {
    try {
      _isLoading = true;
      var data = await HttpService.shared.popular();
      setState(() {
        _results = data;
        _isLoading = false;
      });
    } on Exception catch(error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${error.toString().substring(11)}',
          style: TextStyle(
              decorationColor: Colors.greenAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ));
    }
  }

  void _fetchNew() async {
    try {
      _isLoading = true;
      var data = await HttpService.shared.news();
      setState(() {
        _results = data;
        _isLoading = false;
      });
    } on Exception catch(error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${error.toString().substring(11)}',
          style: TextStyle(
              decorationColor: Colors.greenAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ));
    }
  }

  void _fetchForYou() async {
    try {
      _isLoading = true;
      var data = await HttpService.shared.forYou();
      setState(() {
        _results = data;
        _isLoading = false;
      });
    } on Exception catch(error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${error.toString().substring(11)}',
          style: TextStyle(
              decorationColor: Colors.greenAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchPopular();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(
              image: AssetImage('assets/logoOnly.png'),
            ),
            Text(
              "Renaissance",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
            )
          ]),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          CupertinoSegmentedControl(
            children: {0: Text("POPULAR"), 1: Text("FOR YOU"), 2: Text("NEW")},
            onValueChanged: (value) {
              int index = value as int;
              if (index == 0) {
                _fetchPopular();
              } else if (index == 1) {
                _fetchForYou();
              } else {
                _fetchNew();
              }
              setState(() {
                _pageIndex = value as int;
              });
            },
            padding: EdgeInsets.all(5),
            groupValue: _pageIndex,
            selectedColor: Colors.red,
            borderColor: Colors.black,
          ),
          Container(
            child: Text("TAGS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0)),
            color: Colors.grey.shade300,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _results.topics.map((topic) => TagContainer(topic: topic,)).toList()
              ),
            ),
          ),
          Container(
            child: Text("PATHS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0)),
            color: Colors.grey.shade300,
          ),
          ..._results.paths.map((path) => CourseContainer(key: Key(path.id), path: path))
        ],
      ),
    );
  }
}
