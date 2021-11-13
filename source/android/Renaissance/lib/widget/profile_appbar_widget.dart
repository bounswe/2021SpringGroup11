import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portakal/settings_page.dart';

import '../my_colors.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    backgroundColor: MyColors.blue,
    leading: IconButton(
      icon:  FaIcon(FontAwesomeIcons.userEdit),
      onPressed: (){},
    ),
    elevation: 0,
    actions: [
      IconButton(
        icon: FaIcon(FontAwesomeIcons.cog),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
        },
      ),
    ],
  );
}