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

  test('Find index functionailty check', () {
    final widget = CreatePathPage();
    final element = widget.createElement(); // this will set state.widget
    final state = element.state as CreatePathPageState;

    state.typeOfController.add("t1");
    state.typeOfController.add("t2");
    state.typeOfController.add("t1");
    state.typeOfController.add("t1");
    state.typeOfController.add("t1");
    state.typeOfController.add("t2");

    expect(state.typeOfController, isNotEmpty);

    expect(state.findIndex(5), 2);
    expect(state.findIndex(4), 4);
    expect(state.findIndex(1), 1);
  });

  test('Delete item functionailty check', () {
    final widget = CreatePathPage();
    final element = widget.createElement(); // this will set state.widget
    final state = element.state as CreatePathPageState;

    state.titleControllers.add(TextEditingController());
    state.descControllers.add(TextEditingController());
    state.titleFields.add(TextField());
    state.descFields.add(TextField());
    state.typeOfController.add("test");
    state.titleControllers.add(TextEditingController());
    state.descControllers.add(TextEditingController());
    state.titleFields.add(TextField());
    state.descFields.add(TextField());
    state.typeOfController.add("test");

    expect(state.titleControllers.length, 2);
    expect(state.descControllers.length, 2);
    expect(state.titleFields.length, 2);
    expect(state.descFields.length, 2);
    expect(state.typeOfController.length, 2);

    state.deleteItem(1);

    expect(state.titleControllers.length, 1);
    expect(state.descControllers.length, 1);
    expect(state.titleFields.length, 1);
    expect(state.descFields.length, 1);
    expect(state.typeOfController.length, 1);

    state.deleteItem(0);

    expect(state.titleControllers, isEmpty);
    expect(state.descControllers, isEmpty);
    expect(state.titleFields, isEmpty);
    expect(state.descFields, isEmpty);
    expect(state.typeOfController, isEmpty);
  });

  testWidgets('Checking custom items widget', (WidgetTester tester) async {
    Widget testWidget = MaterialApp(
        home: Material(
            child: new MediaQuery(
                data: new MediaQueryData(), child: CreatePathPage())));

    await tester.pumpWidget(testWidget);
    final CreatePathPageState state = tester.state(find.byType(CreatePathPage));

    state.titleControllers.add(TextEditingController());
    state.descControllers.add(TextEditingController());
    state.titleFields.add(TextField());
    state.descFields.add(TextField());
    state.typeOfController.add("test");
    state.titleControllers.add(TextEditingController());
    state.descControllers.add(TextEditingController());
    state.titleFields.add(TextField());
    state.descFields.add(TextField());
    state.typeOfController.add("test");
    state.setState(() {});

    await tester.pump();

    expect(
        ((tester.firstWidget(find.byKey(const Key("items"))) as Column)
                .children)
            .length,
        2);
  });
}
