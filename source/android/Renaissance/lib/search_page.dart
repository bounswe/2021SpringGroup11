import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/user.dart';

import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:portakal/widget/tag_container.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _topics = [];
  var _paths = [];
  var _users = [];
  String _keyword = "";
  @override
  Widget build(BuildContext context) {
    void _search() async {
      var topics = await HttpService.shared.searchTopic(_keyword);
      var paths = await HttpService.shared.searchPath(_keyword);
      var users = await HttpService.shared.searchUser(_keyword);
      setState(() {
        _topics = topics;
        _paths = paths;
        _users = users;
      });
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.blue,
          leading: const Image(
            image: AssetImage('assets/logoOnly.png'),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _search();
                  });
                },
                icon: Icon(Icons.search))
          ],
          title: Container(
            height: 40,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: Center(
              child: TextField(
                onSubmitted: (query) {
                  setState(() {
                    _keyword = query;
                  });
                  _search();
                },
                onChanged: (query) {
                  setState(() {
                    _keyword = query;
                  });
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none),
              ),
            ),
          )),
      body: ListView(
        children: [
          if (_paths.isNotEmpty)
            ...(_paths as List<BasicPath>).map((path) {
              return CourseContainer(key: Key(path.id!), path: path);
            }).toList(),
          if (_topics.isNotEmpty)
            ...(_topics as List<Tag>).map((tag) {
              return TagContainer(key: Key(tag.id!), tag: tag);
            }).toList(),
          if (_users.isNotEmpty)
            ...(_users as List<String>).map((user) {
              return Text(user);
            }).toList(),
        ],
      ),
    );
  }
}
