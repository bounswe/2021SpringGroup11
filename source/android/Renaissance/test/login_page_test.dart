// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portakal/models/tag.dart';

import 'package:portakal/login_page.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:portakal/widget/tag_search_container.dart';

void main() {
  test('initial Login page index checks', () {
    final widget = LoginPage();
    final element = widget.createElement(); // this will set state.widget
    final state = element.state as LoginPageState;

    expect(state.username, "");
    expect(state.password, "");
  });

  // testWidgets('Login page creation check', (WidgetTester tester) async {
  //   Widget testWidget = MaterialApp(
  //       home: Material(
  //           child: new MediaQuery(
  //               data: new MediaQueryData(), child: LoginPage())));

  //   await tester.pumpWidget(testWidget);

  //   final findert1 = find.text("Forgot Password?");
  //   final findert2 = find.text("Login");

  //   expect(findert1, findsWidgets);
  //   expect(findert2, findsWidgets);
  // });
}
