
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

import 'http_services.dart';
import 'models/user.dart';
import 'my_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var _image;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: MyColors.blue,
            title: Text("Edit Profile"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: _image == null ? Image(
                    image: AssetImage('assets/thomyorke.jpg'),
                    height: 80.0,
                    width: 80.0,
                  ): Image.file(_image, width: 80, height: 80, fit: BoxFit.fitHeight,),
                ),
                Text(
                  '@${User.me!.username}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                MaterialButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (image != null) {
                        _image = File(image.path);
                      }
                    });
                  },
                  textColor: Colors.white70,
                  shape: StadiumBorder(),
                  child: Text(
                    'Change profile picture',

                  ),
                  color: MyColors.blue,
                ),
                 Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('First Name',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                          maxLength: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10)
                          ),
                          controller: firstNameController..text = User.me!.firstname!,
                        style: TextStyle(
                            color: Color(0xff3c3c3c),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                      Text('Last Name',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        maxLength: 20,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10)
                        ),
                        controller: lastNameController..text = User.me!.lastname!,
                        style: TextStyle(
                            color: Color(0xff3c3c3c),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                      Text('About',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                      ),
                      TextField(
                          maxLength: 200,
                          maxLines: 5,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10.0)
                          ),
                          controller: bioController..text = User.me!.bio!,
                          style: TextStyle(
                              color: Color(0xff3c3c3c),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400)
                      ),
                      MaterialButton(
                        onPressed: () async {
                          try {
                            setState(() {
                              _isLoading = true;
                            });
                            User response = await HttpService.shared.editUser(firstNameController.text, lastNameController.text, bioController.text);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  'Successful ${response.username}!',
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
                        ) : Text('Save'),
                        shape: StadiumBorder(),
                        color: MyColors.red,
                      )
                    ],
                  ),
                Spacer()
              ],
            ),
          )
        ),
    );
  }
}