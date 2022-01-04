import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/cutsom_checkbox_widget.dart';

class MilestoneContainer extends StatefulWidget {
  MilestoneContainer(this.ID,this.milestone_title, this.milestone_description, this.is_completed, this.type);
  final String ID;
  final String milestone_title;
  final String milestone_description;
  final bool is_completed;
  final int type;

  @override
  State<MilestoneContainer> createState() => _MilestoneContainerState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MilestoneContainerState extends State<MilestoneContainer> {
  bool _isInital = true;
  bool state_checkbox_value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
          borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: LabeledCheckbox(
        title: widget.milestone_title,
        description: widget.milestone_description,
        value: _isInital?widget.is_completed:state_checkbox_value,
        onChanged: (bool newValue) async{
          if (newValue) {
            try {
              var response = await HttpService.shared.fav_path(User.me!.username!, widget.ID);
            } on Exception catch (error) {

            }
          } else {
            try {
              var response = await HttpService.shared.unfav_path(User.me!.username!, widget.ID);
            } on Exception catch (error) {
            }
          }
          setState(() {
            state_checkbox_value = newValue;
            _isInital = false;
          });
        },
      )
    );
  }
}
