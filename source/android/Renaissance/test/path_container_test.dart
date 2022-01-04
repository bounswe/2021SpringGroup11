// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portakal/main.dart';
import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/milestone_model.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:portakal/widget/cutsom_checkbox_widget.dart';

void main() {

  testWidgets('Check how path container rendered, when photo not provided ', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: CourseContainer(path: BasicPath(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: false),)
        )));
    await tester.pumpWidget(testWidget);
    final titleFinder = find.byType(CircleAvatar);
    expect(titleFinder, findsOneWidget);

  });

  testWidgets('Check if hearth rendered red, on favorited path', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: CourseContainer(path: BasicPath(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: true),)
        )));
    await tester.pumpWidget(testWidget);
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color, Colors.red);


  });
  testWidgets('Check if hearth rendered red, on unfavorited path', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: CourseContainer(path: BasicPath(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: false),)
        )));
    await tester.pumpWidget(testWidget);
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color, null);


  });

  testWidgets('Check if precision fixed to 2', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: CourseContainer(path: BasicPath(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: false),)
        )));
    await tester.pumpWidget(testWidget);
    final titleFinder = find.text(3.123818.toStringAsFixed(2));
    final descriptionFinder = find.text(5.123818.toStringAsFixed(2));
    final noTitleFinder = find.text(3.123818.toString());

    expect(titleFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);
    expect(noTitleFinder, findsNothing);

  });



}
