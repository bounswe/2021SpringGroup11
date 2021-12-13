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

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  void clearMilestones() {
    _titleControllers = [];
    _titleFields = [];
    _descControllers = [];
    _descFields = [];
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
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
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
            hintText: "Title...",
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
              hintText: "Description...",
              contentPadding: EdgeInsets.all(10.0)),
        );

        setState(() {
          _titleControllers.add(titleController);
          _titleFields.add(titleField);
          _descControllers.add(descController);
          _descFields.add(descField);
        });
      },
    );
  }

  Widget _milestones() {
    final children = [
      for (var i = 0; i < _titleControllers.length; i++)
        Container(
          margin: EdgeInsets.all(5),
          child: InputDecorator(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                _titleFields[i],
                Text(
                  "Description ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                _descFields[i],
              ],
            ),
            decoration: InputDecoration(
              labelText: "Milestone " + (i + 1).toString(),
              labelStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
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
                'Milestones',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              _milestones(),
              _addTile(),
              MaterialButton(
                onPressed: () async {
                  try {
                    setState(() {
                      _isLoading = true;
                    });

                    List<Map<String, String>> milestones = [];
                    List<Map<String, String>> topics = [];

                    for (var i = 0; i < _titleControllers.length; i++) {
                      milestones.add({
                        "title": _titleControllers[i].text,
                        "body": _descControllers[i].text
                      });
                    }

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

                    User response = await HttpService.shared.createPath(
                      titleController.text,
                      descriptionController.text,
                      milestones,
                      _image == null
                          ? ""
                          : FileConverter.getBase64StringFile(_image),
                      sendTopic,
                    );
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
                    clearMilestones();
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
                        '$error',
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
                color: MyColors.red,
              ),
            ],
          )),
    );
  }
}
