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
import 'package:portakal/widget/milestone_widget.dart';
import 'package:portakal/widget/cutsom_checkbox_widget.dart';

void main() {

  testWidgets('Check if Milestonee container gets parameter and renders for MILESTONE ', (WidgetTester tester) async{
    Widget testWidget =
    MaterialApp(
        home:Material(child:new MediaQuery(
        data: new MediaQueryData(),
        child: MilestoneContainer("AABBCC", "MilestoneTitle", "This is a description", true, 1)
    )));
    await tester.pumpWidget(testWidget);

    expect(((tester.firstWidget(find.byType(Container)) as Container).decoration as BoxDecoration).color, Colors.orangeAccent);
    final titleFinder = find.text('MilestoneTitle');
    final descriptionFinder = find.text('This is a description');
    expect(titleFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);

  });
  testWidgets('Check if Milestone container gets parameter and renders for TASK ', (WidgetTester tester) async{
    Widget testWidgetRed =
    MaterialApp(
        home:Material(child:new MediaQuery(
            data: new MediaQueryData(),
            child: MilestoneContainer("AABBCC", "MilestoneTitleRed", "This is a description for red", true, 0)
        )));
    await tester.pumpWidget(testWidgetRed);
    expect(((tester.firstWidget(find.byType(Container)) as Container).decoration as BoxDecoration).color, Colors.redAccent);
    expect(find.byType(LabeledCheckbox), findsOneWidget);

    final titleFinderRed = find.text('MilestoneTitleRed');
    final descriptionFinderRed = find.text('This is a description for red');
    expect(titleFinderRed, findsOneWidget);
    expect(descriptionFinderRed, findsOneWidget);

  });



}
