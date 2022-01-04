import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/basic_user.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/user.dart';

import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:portakal/widget/tag_search_container.dart';
import 'package:portakal/widget/user_container.dart';

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
    void _searchT() async {
      var topics = await HttpService.shared.searchTopic(_keyword);

      setState(() {
        _topics = topics;
      });
    }

    void _searchP() async {
      var paths = await HttpService.shared.searchPath(_keyword);
      setState(() {
        _paths = paths;
      });
    }

    void _searchU() async {
      var users = await HttpService.shared.searchUser(_keyword);
      setState(() {
        _users = users;
      });
    }

    void _search() async {
      _searchT();
      _searchP();
      _searchU();
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
          SizedBox(
            //Use of SizedBox
            height: 10,
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
                children: [
                  if (_topics.isNotEmpty)
                    ...(_topics as List<Tag>).map((tag) {
                      return TagSearchContainer(key: Key(tag.id!), tag: tag);

                    }).toList(),
                  if (_topics.isEmpty)
                    Text(
                      "No Topic to show !",
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    )
                ],
              ),
            ),
          ),
          Container(
            child: Text("Users",
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
                children: [
                  if (_users.isNotEmpty)
                    ...(_users as List<BasicUser>).map((user) {
                      return UserContainer(user: user);
                    }).toList(),
                  if (_users.isEmpty)
                    Text(
                      "No User to show !",
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    )
                ],
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
          if (_paths.isNotEmpty)
            ...(_paths as List<BasicPath>).map((path) {
              return CourseContainer(key: Key(path.id), path: path);
            }).toList(),
          if (_paths.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "No Path to show!",
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
