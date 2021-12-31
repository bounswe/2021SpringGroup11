import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portakal/file_converter.dart';
import 'package:portakal/models/tag.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

import 'http_services.dart';
import 'models/user.dart';
import 'my_colors.dart';

class CreatePathPage extends StatefulWidget {
  const CreatePathPage({Key? key}) : super(key: key);

  @override
  _CreatePathPageState createState() => _CreatePathPageState();
}

class _CreatePathPageState extends State<CreatePathPage> {
  var _image;
  bool _isLoading = false;

  List<TextEditingController> _titleControllers = [];
  List<TextField> _titleFields = [];
  List<TextEditingController> _descControllers = [];
  List<TextField> _descFields = [];

  List<String> _typeOfController = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  void clearItems() {
    _titleControllers = [];
    _titleFields = [];
    _descControllers = [];
    _descFields = [];
    _typeOfController = [];
  }

  int findIndex(int i) {
    String type = _typeOfController[i];
    int index = 1;
    for (int ind = 0; ind < i; ind++) {
      if (_typeOfController[ind] == type) {
        index += 1;
      }
    }
    return index;
  }

  void _deleteItem(int i) {
    setState(() {
      _titleControllers.removeAt(i);
      _titleFields.removeAt(i);
      _descControllers.removeAt(i);
      _descFields.removeAt(i);
      _typeOfController.removeAt(i);
    });
  }

  @override
  void dispose() {
    for (final controller in _titleControllers) {
      controller.dispose();
    }
    for (final controller in _descControllers) {
      controller.dispose();
    }
    titleController.dispose();
    descriptionController.dispose();
    topicController.dispose();
    super.dispose();
  }

  Widget _addTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: Text('Add Task'),
          style: TextButton.styleFrom(
            primary: MyColors.coolGray,
            backgroundColor: Colors.orangeAccent,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            final titleController = TextEditingController();
            final titleField = TextField(
              controller: titleController,
              maxLength: 50,
              style: TextStyle(
                  color: MyColors.coolGray,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: " Task Title...",
              ),
            );
            final descController = TextEditingController();
            final descField = TextField(
              controller: descController,
              maxLength: 200,
              maxLines: 5,
              style: TextStyle(
                  color: MyColors.coolGray,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: " Task Description...",
                  contentPadding: EdgeInsets.all(10.0)),
            );

            setState(() {
              _titleControllers.add(titleController);
              _titleFields.add(titleField);
              _descControllers.add(descController);
              _descFields.add(descField);
              _typeOfController.add("Task");
            });
          },
        ),
        TextButton(
          child: Text('Add Milestone'),
          style: TextButton.styleFrom(
            primary: MyColors.coolGray,
            backgroundColor: Colors.amberAccent,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            final titleController = TextEditingController();
            final titleField = TextField(
              controller: titleController,
              maxLength: 50,
              style: TextStyle(
                  color: MyColors.coolGray,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Milestone Title...",
              ),
            );
            final descController = TextEditingController();
            final descField = TextField(
              controller: descController,
              maxLength: 200,
              maxLines: 5,
              style: TextStyle(
                  color: MyColors.coolGray,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Milestone Description...",
                  contentPadding: EdgeInsets.all(10.0)),
            );

            setState(() {
              _titleControllers.add(titleController);
              _titleFields.add(titleField);
              _descControllers.add(descController);
              _descFields.add(descField);
              _typeOfController.add("Milestone");
            });
          },
        ),
      ],
    );
  }

  Widget _items() {
    final children = [
      for (var i = 0; i < _titleControllers.length; i++)
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _typeOfController[i] + " " + findIndex(i).toString(),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MyColors.darkGray),
                    ),
                    TextButton(
                      onPressed: () => _deleteItem(i),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Text(
                  _typeOfController[i] + " Title",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                _titleFields[i],
                Text(
                  _typeOfController[i] + " Description ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                _descFields[i],
              ],
            ),
            decoration: InputDecoration(),
          ),
        )
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: MyColors.blue,
            title: Text("Create New Path"),
            centerTitle: true,
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20.0),
            children: [
              Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(300.0),
                      child: _image != null
                          ? Image.file(
                              _image,
                              width: 160,
                              height: 90,
                              fit: BoxFit.fitHeight,
                            )
                          : Image(
                              image: AssetImage('assets/placeHolder.jpg'),
                              width: 160,
                              height: 90,
                              fit: BoxFit.fitHeight,
                            )),
                  Center(
                      child: Text(
                    'Your Path...',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  )),
                  MaterialButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        if (image != null) {
                          _image = File(image.path);
                        }
                      });
                    },
                    textColor: Colors.white70,
                    shape: StadiumBorder(),
                    child: Text(
                      'Change Path Image',
                    ),
                    color: MyColors.blue,
                  )
                ],
              ),
              Text(
                'Title',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLength: 50,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Your title",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                controller: titleController,
                style: TextStyle(
                    color: MyColors.coolGray,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Description',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLength: 200,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Your description...",
                    contentPadding: EdgeInsets.all(10.0)),
                controller: descriptionController,
                style: TextStyle(
                    color: MyColors.coolGray,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Topics',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLength: 70,
                maxLines: 2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Topics",
                    contentPadding: EdgeInsets.all(10.0)),
                controller: topicController,
                style: TextStyle(
                    color: MyColors.coolGray,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                'Tasks and Milestones',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              _items(),
              _addTile(),
              MaterialButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        _isLoading = true;
                      });

                      if (titleController.text == "")
                        throw Exception('Please give a title!');

                      if (descriptionController.text == "")
                        throw Exception('Please give a description!');

                      if (topicController.text == "")
                        throw Exception('Please give some topic!');

                      for (var item in _titleControllers)
                        if (item.text == "")
                          throw Exception('Please fill all milestone titles!');

                      for (var item in _descControllers)
                        if (item.text == "")
                          throw Exception(
                              'Please fill all milestone descriptions!');

                      List<Map<String, String>> items = [];
                      List<Map<String, String>> topics = [];

                      for (var i = 0; i < _titleControllers.length; i++) {
                        items.add({
                          "title": _titleControllers[i].text,
                          "body": _descControllers[i].text,
                          "type": _typeOfController[i],
                        });
                      }
                      print(items);

                      List<String> splitted = topicController.text.split(",");

                      List<Tag> topicsSubmit = [];
                      for (var item in splitted) {
                        List<Tag> resultTags =
                            await HttpService.shared.searchTopic(item.trim());

                        resultTags = [resultTags[0]];
                        topicsSubmit = topicsSubmit + resultTags;
                      }

                      for (var i = 0; i < topicsSubmit.length; i++) {
                        print(topicsSubmit[i].name);
                        print(topicsSubmit[i].description);
                      }

                      List<Map<String, Object>> sendTopic = [];
                      for (var i = 0; i < topicsSubmit.length; i++) {
                        sendTopic.add({
                          "ID": int.parse(topicsSubmit[i].id as String),
                          "name": topicsSubmit[i].name as String,
                          "description": topicsSubmit[i].description as String
                        });
                      }

                      // User response = await HttpService.shared.createPath(
                      //   titleController.text,
                      //   descriptionController.text,
                      //   items,
                      //   _image == null
                      //       ? ""
                      //       : FileConverter.getBase64StringFile(_image),
                      //   sendTopic,
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Successfully created ${titleController.text}',
                          style: TextStyle(
                              decorationColor: Colors.greenAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ));

                      titleController.clear();
                      descriptionController.clear();
                      topicController.clear();
                      clearItems();
                      _image = null;

                      setState(() {
                        _isLoading = false;
                      });
                    } on Exception catch (error) {
                      setState(() {
                        _isLoading = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          '${error.toString().substring(11)}',
                          style: TextStyle(
                              decorationColor: Colors.greenAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ));
                    }
                  },
                  child: _isLoading
                      ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text('Save'),
                  shape: StadiumBorder(),
                  color: Colors.greenAccent),
            ],
          )),
    );
  }
}
