// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portakal/main.dart';
import 'package:portakal/models/milestone_model.dart';
import 'package:portakal/models/tag.dart';

void main() {

  test('Check if Milestonee intiliazer creates instance for Milestonnee and assigns parameter properly', () {
    final model = Milestonee(title:"MilestoneTitle",body: "This is a description",isFinished: true,id: "AABBCC", type: 0);
    expect(model is Milestonee, true);
    expect(model is Tag, false);
    expect(model.id, "AABBCC");
  });
  test('Check if Milestonee instance can be created from JSON and assigns parameter properly', () {
    var json = {
      "title": "John Smith",
      "body": "john@example.com",
      "isFinished":true,
      "_id":"AABBCC",
      "type":0
    };
    final model = Milestonee.fromJson(json);
    expect(model is Milestonee, true);
    expect(model is Tag, false);
    expect(model.id, "AABBCC");
  });
  test('Check if Milestonee instance can be created from JSON and assigns parameter properly', () {
    var json = {
      "title": "John Smith",
      "body": "john@example.com",
      "isFinished":true,
      "_id":"AABBCC",
      "type":0
    };
    final model = Milestonee.fromJson(json);
    expect(model is Milestonee, true);
    expect(model is Tag, false);
    expect(model.id, "AABBCC");
  });



}
