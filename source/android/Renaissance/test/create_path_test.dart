// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portakal/models/tag.dart';

import 'package:portakal/create_path.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:portakal/widget/tag_search_container.dart';

void main() {
  test('initial list empty checks', () {
    final widget = CreatePathPage();
    final element = widget.createElement(); // this will set state.widget
    final state = element.state as CreatePathPageState;
    expect(state.topics, isEmpty);
    expect(state.titleController, isNotNull);
    expect(state.topicController, isNotNull);
    expect(state.descriptionController, isNotNull);
  });

  test('Clear items functionailty checks', () {
    final widget = CreatePathPage();
    final element = widget.createElement(); // this will set state.widget
    final state = element.state as CreatePathPageState;

    state.titleControllers.add(TextEditingController());
    state.descControllers.add(TextEditingController());
    state.titleFields.add(TextField());
    state.descFields.add(TextField());
    state.typeOfController.add("test");

    expect(state.titleControllers, isNotEmpty);
    expect(state.descControllers, isNotEmpty);
    expect(state.titleFields, isNotEmpty);
    expect(state.descFields, isNotEmpty);
    expect(state.typeOfController, isNotEmpty);

    state.clearItems();

    expect(state.titleControllers, isEmpty);
    expect(state.descControllers, isEmpty);
    expect(state.titleFields, isEmpty);
    expect(state.descFields, isEmpty);
    expect(state.typeOfController, isEmpty);
  });
}
