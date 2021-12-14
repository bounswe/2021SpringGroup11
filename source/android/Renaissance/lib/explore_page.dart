import 'package:flutter/material.dart';
import 'package:portakal/my_colors.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Text('PAGE IS IN DEVELOPMENT!!', style: TextStyle(fontSize: 32, color: MyColors.red,), textAlign: TextAlign.center,),
    );
  }
}