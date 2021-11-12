import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    backgroundColor: Color(0xFF70A9FF),
    leading: IconButton(
      icon:  FaIcon(FontAwesomeIcons.userEdit),
      onPressed: (){},
    ),
    flexibleSpace: Column(
      children: [
        const SizedBox(height: 25),
        Text('JohnDoe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white)),
        const SizedBox(height: 4),
        Container(
          height: 25.0,
          width: 175.0,
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0x99FFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: new Center(
                child: new Text('GRANDMASTER',
                  style: TextStyle(fontSize: 20, color: Color(0xFFEB5757)),
                  textAlign: TextAlign.center,),
              )
          ),
        ),
      ],
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