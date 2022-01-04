// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portakal/models/tag.dart';

import 'package:portakal/settings_page.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:portakal/widget/tag_search_container.dart';

void main() {
  test('initial setting page index checks', () {
    final widget = SettingsPage();
    final element = widget.createElement(); // this will set state.widget
    final state = element.state as SettingsPageState;

    expect(state.allowNotifications, true);
    expect(state.favoritePaths, true);
    expect(state.enrolledPaths, true);
    expect(state.favoriteTopics, true);
  });

  testWidgets('Settings page creation check', (WidgetTester tester) async {
    Widget testWidget = MaterialApp(
        home: Material(
            child: new MediaQuery(
                data: new MediaQueryData(), child: SettingsPage())));

    await tester.pumpWidget(testWidget);

    final finderPath = find.text("Favorite Paths");
    final findert1 = find.text("Enrolled Paths");
    final findert2 = find.text("My Paths");

    final findert3 = find.text("Change Password");

    final finderTag = find.text("Favorite Topics");
    expect(finderPath, findsOneWidget);
    expect(findert1, findsWidgets);
    expect(findert2, findsWidgets);
    expect(findert3, findsWidgets);

    expect(finderTag, findsWidgets);
  });
}
