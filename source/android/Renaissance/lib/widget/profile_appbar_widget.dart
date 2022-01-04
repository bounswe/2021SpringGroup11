import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portakal/edit_profile.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/settings_page.dart';

import '../my_colors.dart';

AppBar buildAppBar(BuildContext context, String username, EditProfileDelegate delegate){
  return AppBar(
    backgroundColor: MyColors.blue,
    flexibleSpace:
        Align(
          alignment: Alignment.center,
          child: Text("@${username}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26, color: Colors.white)),
        ),
    elevation: 0,
    actions: username == User.me!.username ? [
      IconButton(
        icon: FaIcon(FontAwesomeIcons.cog),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
        },
      ),
      IconButton(
        icon:  FaIcon(FontAwesomeIcons.userEdit),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(delegate: delegate,)));
        },
      ),
    ] : [],
  );
}