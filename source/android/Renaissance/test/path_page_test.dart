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
import 'package:portakal/models/topic_model.dart';
import 'package:portakal/path_page.dart';
import 'package:portakal/models/path.dart';
import 'package:portakal/widget/course_container.dart';
import 'package:portakal/widget/cutsom_checkbox_widget.dart';
import 'package:portakal/widget/milestone_widget.dart';

void main() {

  testWidgets('Check how path container rendered, when photo not provided ', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: PathPage(p: Path(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: false,topics: [],description: "Path description here it is.", milestones: [],creator_username: "hazarbeymidir",creator_email: "aaa@aaa.com", created_at: 12321312,isEnrolled: true),)
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
            child: PathPage(p: Path(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: true,topics: [],description: "Path description here it is.", milestones: [],creator_username: "hazarbeymidir",creator_email: "aaa@aaa.com", created_at: 12321312,isEnrolled: true),)
        )));
    await tester.pumpWidget(testWidget);
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color, Colors.red);


  });
  testWidgets('Check if hearth rendered red, on unfavorited path', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: PathPage(p: Path(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: false,topics: [],description: "Path description here it is.", milestones: [],creator_username: "hazarbeymidir",creator_email: "aaa@aaa.com", created_at: 12321312,isEnrolled: true),)
        )));
    await tester.pumpWidget(testWidget);
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color, null);


  });


  testWidgets('Check if milestones are rendered correctly', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: PathPage(p: Path(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: false,topics: [],description: "Path description here it is.", milestones: [Milestonee(id: "IDM1",type: 0,isFinished: false,body: "Task Description",title: "Milestone1")],creator_username: "hazarbeymidir",creator_email: "aaa@aaa.com", created_at: 12321312,isEnrolled: true),)
        )));
    await tester.pumpWidget(testWidget);
    final milestoneContainer = find.byType(MilestoneContainer);


    expect(milestoneContainer, findsOneWidget);

  });

  testWidgets('Check if tags are rendered correctly', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: PathPage(p: Path(title: "Path One", id: "IDID", effort: 3.123818, rating: 5.123818,photo:"",isFollowed: false,topics: [Topic(ID: 22,description: "Description for Tag1",name: "Tag1"),Topic(ID: 23,description: "Description for Tag2",name: "Tag2")],description: "Path description here it is.", milestones: [Milestonee(id: "IDM1",type: 0,isFinished: false,body: "Task Description",title: "Milestone1")],creator_username: "hazarbeymidir",creator_email: "aaa@aaa.com", created_at: 12321312,isEnrolled: true),)
        )));
    await tester.pumpWidget(testWidget);
    final tagsContainer = find.byType(ButtonTheme);


    expect(tagsContainer, findsNWidgets(2));

  });

}
