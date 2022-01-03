import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/widget/cutsom_checkbox_widget.dart';

class ActivityContainer extends StatefulWidget {
  ActivityContainer(this.summary,this.time);
  final String summary;
  final String time;

  @override
  State<ActivityContainer> createState() => _ActivityContainerrState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ActivityContainerrState extends State<ActivityContainer> {
  bool _isInital = true;
  bool state_checkbox_value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: Column(
          children: [
            Text(widget.summary,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16)),
            Text(widget.time,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 12,color: Colors.grey))
          ],
        )
    );
  }
}
