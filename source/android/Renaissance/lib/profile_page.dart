import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/my_colors.dart';
import 'models/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  const ProfilePage({ Key? key, required this.user }): super(key: key);
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        leading: IconButton(
          iconSize: 36,
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
              iconSize: 36,
          )
        ],
        backgroundColor: MyColors.blue,
      ),
      body: Text(widget.user.toString()),
    );
  }
}