// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portakal/models/tag.dart';

import 'package:portakal/search_page.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:portakal/widget/tag_search_container.dart';

void main() {
  test('initial list empty checks', () {
    final widget = SearchPage();
    final element = widget.createElement(); // this will set state.widget
    final state = element.state as SearchPageState;
    expect(state.topics, isEmpty);
    expect(state.paths, isEmpty);
    expect(state.users, isEmpty);
  });

  testWidgets('Search page creation check', (WidgetTester tester) async {
    Widget testWidget = MaterialApp(
        home: Material(
            child: new MediaQuery(
                data: new MediaQueryData(), child: SearchPage())));

    await tester.pumpWidget(testWidget);

    final finderPath = find.text('PATHS');
    final finderUser = find.text('Users');
    final finderTag = find.text('TAGS');
    expect(finderPath, findsOneWidget);
    expect(finderUser, findsWidgets);
    expect(finderTag, findsWidgets);
  });
}
