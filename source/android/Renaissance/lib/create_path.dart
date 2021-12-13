import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portakal/file_converter.dart';
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
  var _milestones;

  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        final controller = TextEditingController();
        final field = TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Milestone ${_controllers.length + 1}",
          ),
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);
        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          child: _fields[index],
        );
      },
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
            title: Text("Create a New Path"),
            centerTitle: true,
          ),
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(32.0),
                          child: _image != null
                              ? Image.file(
                                  _image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fitHeight,
                                )
                              : Image(
                                  image: AssetImage('assets/placeHolder.jpg'),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fitHeight,
                                )),
                      Text(
                        'Your Path...',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
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
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            maxLength: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Your title",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10)),
                            controller: titleController,
                            style: TextStyle(
                                color: MyColors.coolGray,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                          _addTile(),
                          _listView(),
                          MaterialButton(
                            onPressed: () async {
                              try {
                                setState(() {
                                  _isLoading = true;
                                });

                                // User response = await HttpService.shared
                                //     .createPath(
                                //         titleController.text,
                                //         descriptionController.text,
                                //         _milestones,
                                //         _image == null
                                //             ? FileConverter.getBase64StringPath(
                                //                 "assets/placeHolder.jpg")
                                //             : FileConverter.getBase64StringFile(
                                //                 _image),
                                //         [1]);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Successfully created ${titleController.text}',
                                    style: TextStyle(
                                        decorationColor: Colors.greenAccent,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ));

                                setState(() {
                                  _isLoading = false;
                                });
                              } on Exception catch (error) {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
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
                          )
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
