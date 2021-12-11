import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portakal/edit_profile.dart';
import 'package:portakal/settings_page.dart';

import '../my_colors.dart';

AppBar buildAppBar(BuildContext context, String username, EditProfileDelegate delegate){
  return AppBar(
    backgroundColor: MyColors.blue,
    flexibleSpace: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: new Center(
              child: new Text('BEGINNER',
                style: TextStyle(fontSize: 20, color: Color(0xFFEB5757)),
                textAlign: TextAlign.center,),
            )
        ),
        SizedBox(width: 15,),
        Text(username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white)),
      ],
    ),
    elevation: 0,
    actions: [
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
    ],
  );
}