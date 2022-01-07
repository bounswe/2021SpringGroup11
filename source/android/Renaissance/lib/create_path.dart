import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portakal/file_converter.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/widget/tag_container.dart';
import 'package:portakal/widget/tag_desc_container.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

import 'http_services.dart';
import 'models/user.dart';
import 'my_colors.dart';
import 'widget/tag_create_container.dart';

class CreatePathPage extends StatefulWidget {
  const CreatePathPage({Key? key}) : super(key: key);

  @override
  CreatePathPageState createState() => CreatePathPageState();
}

@visibleForTesting
class CreatePathPageState extends State<CreatePathPage> {
  var _image;
  bool _isLoading = false;

  var topics = <Tag>[];

  List<TextEditingController> titleControllers = [];
  List<TextField> titleFields = [];
  List<TextEditingController> descControllers = [];
  List<TextField> descFields = [];

  List<String> typeOfController = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  void clearItems() {
    titleControllers = [];
    titleFields = [];
    descControllers = [];
    descFields = [];
    typeOfController = [];
    topics = [];

    titleController.clear();
    descriptionController.clear();
    topicController.clear();
  }

  int findIndex(int i) {
    String type = typeOfController[i];
    int index = 1;
    for (int ind = 0; ind < i; ind++) {
      if (typeOfController[ind] == type) {
        index += 1;
      }
    }
    return index;
  }

  void deleteItem(int i) {
    setState(() {
      titleControllers.removeAt(i);
      titleFields.removeAt(i);
      descControllers.removeAt(i);
      descFields.removeAt(i);
      typeOfController.removeAt(i);
    });
  }

  Future<dynamic> _searchTopic() async {
    List<Tag> resultTags =
        await HttpService.shared.searchTopic(topicController.text.trim());

    topicController.clear();
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose your Topic"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ...(resultTags as List<Tag>).map((tag) {
                  return InkWell(
                      onTap: () {
                        setState(() {
                          topics.add(tag);
                        });
                        Navigator.of(context).pop();
                      },
                      child: (TagDescContainer(key: Key(tag.id!), tag: tag)));
                }).toList(),
                if (resultTags.isEmpty)
                  Text("There is no Topic matching your search!")
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    for (final controller in titleControllers) {
      controller.dispose();
    }
    for (final controller in descControllers) {
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
      key: const Key("addTile"),
      children: [
        TextButton(
          child: Text('Add Task'),
          key: const Key("addTask"),
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
              titleControllers.add(titleController);
              titleFields.add(titleField);
              descControllers.add(descController);
              descFields.add(descField);
              typeOfController.add("Task");
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
              titleControllers.add(titleController);
              titleFields.add(titleField);
              descControllers.add(descController);
              descFields.add(descField);
              typeOfController.add("Milestone");
            });
          },
        ),
      ],
    );
  }

  Widget items() {
    final children = [
      for (var i = 0; i < titleControllers.length; i++)
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
                      typeOfController[i] + " " + findIndex(i).toString(),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: typeOfController[i] == "Task"
                              ? Colors.redAccent
                              : Colors.orangeAccent),
                    ),
                    TextButton(
                      onPressed: () => deleteItem(i),
                      style: TextButton.styleFrom(
                        backgroundColor: typeOfController[i] == "Task"
                            ? Colors.redAccent
                            : Colors.orangeAccent,
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
                  typeOfController[i] + " Title",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                titleFields[i],
                Text(
                  typeOfController[i] + " Description",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                descFields[i],
              ],
            ),
            decoration: InputDecoration(),
          ),
        )
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
      key: Key("items"),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...(topics as List<Tag>).map((tag) {
                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                                color: topics.indexOf(topics.firstWhere(
                                                (element) =>
                                                    (element.id! == tag.id!))) %
                                            2 ==
                                        0
                                    ? Colors.blue.shade200
                                    : Colors.indigo.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TagCreateContainer(key: Key(tag.id!), tag: tag),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        int indice = 0;
                                        for (int i = 0;
                                            i < topics.length;
                                            i++) {
                                          if (topics[i].id == tag.id) {
                                            break;
                                          }
                                        }

                                        topics.removeAt(indice);
                                      });
                                    },
                                    icon: Icon(Icons.cancel_outlined),
                                    color: Colors.redAccent,
                                    splashRadius: 16,
                                    iconSize: 26),
                              ],
                            ));
                      }).toList(),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      maxLength: 70,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Topics",
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      controller: topicController,
                      style: TextStyle(
                        color: MyColors.coolGray,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(onPressed: _searchTopic, icon: Icon(Icons.search))
                ],
              ),
              Text(
                'Tasks and Milestones',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              items(),
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

                      // if (topicController.text == "")
                      //   throw Exception('Please give some topic!');

                      for (var item in titleControllers)
                        if (item.text == "")
                          throw Exception('Please fill all milestone titles!');

                      for (var item in descControllers)
                        if (item.text == "")
                          throw Exception(
                              'Please fill all milestone descriptions!');

                      List<Map<String, Object>> items = [];

                      for (var i = 0; i < titleControllers.length; i++) {
                        items.add({
                          "title": titleControllers[i].text,
                          "body": descControllers[i].text,
                          "type": typeOfController[i] == "Task" ? 0 : 1,
                        });
                      }
                      print(items);

                      List<Map<String, Object>> sendTopic = [];
                      for (var i = 0; i < topics.length; i++) {
                        sendTopic.add({
                          "ID": int.parse((topics[i] as Tag).id as String),
                          "name": (topics[i] as Tag).name as String,
                          "description":
                              (topics[i] as Tag).description as String
                        });
                      }
                      print(topics);
                      print(sendTopic);

                      await HttpService.shared.createPath(
                        titleController.text,
                        descriptionController.text,
                        items,
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
