import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    backgroundColor: Color(0xFF70A9FF),
    leading: IconButton(
      icon:  FaIcon(FontAwesomeIcons.userEdit),
      onPressed: (){},
    ),
    elevation: 0,
    actions: [
      IconButton(
        icon: FaIcon(FontAwesomeIcons.cog),
        onPressed: (){},
      ),
    ],
  );
}