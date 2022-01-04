// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portakal/main.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/basic_path.dart';

import 'package:portakal/topic_page.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:portakal/widget/course_container.dart';

void main() {

  testWidgets('Check if Topic Page is rendered from parameters ', (WidgetTester tester) async{
    Widget testWidget = MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),child:TopicPage(t:Tag(name:"earth",id:"2",description: "Semantic Tag For Earth",isFav: false),paths: [],tags:[]))));

    await tester.pumpWidget(testWidget);
    final titleFinder = find.text('earth');
    final descriptionFinder = find.text('Semantic Tag For Earth');
    expect(titleFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);

  });

  testWidgets('Check if description provided null, "No Description Provided" message is shown. ', (WidgetTester tester) async{
    Widget testWidget = MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),child:TopicPage(t:Tag(name:"earth",id:"2",description: null,isFav: false),paths: [],tags:[]))));

    await tester.pumpWidget(testWidget);
    final descriptionFinder = find.text('No description provided.');
    expect(descriptionFinder, findsOneWidget);

  });

  testWidgets('Check if Tag Container rendered for each tag in the list. ', (WidgetTester tester) async{
    Widget testWidget = MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),child:TopicPage(t:Tag(name:"earth",id:"2",description: null,isFav: false),paths: [BasicPath(title: "Path1", id: "AAIDID", effort: 7.25, rating: 3.11)],tags:[Tag(name:"universe",id:"1",description: "Semantic Tag For Universe",isFav: false),Tag(name:"anothertag",id:"3",description: "Semantic Tag For Anothertag",isFav: false)]))));

    await tester.pumpWidget(testWidget);
    final tagList = find.byType(TagContainer);
    expect(tagList, findsNWidgets(2));

  });

  testWidgets('Check if favorite button rendered accordingly for parameter red', (WidgetTester tester) async{
    Widget testWidget = MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),child:TopicPage(t:Tag(name:"earth",id:"2",description: null,isFav: true),paths: [],tags:[]))));
    await tester.pumpWidget(testWidget);

    expect((tester.firstWidget(find.byType(Icon)) as Icon).color, Colors.red);

  });

  testWidgets('Check if favorite button rendered accordingly for parameter empty', (WidgetTester tester) async{
    Widget testWidget = MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),child:TopicPage(t:Tag(name:"earth",id:"2",description: null,isFav: false),paths: [],tags:[]))));
    await tester.pumpWidget(testWidget);

    expect((tester.firstWidget(find.byType(Icon)) as Icon).color, null);

  });
}
