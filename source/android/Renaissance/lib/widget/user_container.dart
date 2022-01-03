import 'package:flutter/material.dart';
import 'package:portakal/file_converter.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/models/basic_user.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/profile_page.dart';

class UserContainer extends StatefulWidget {
  UserContainer({Key? key, required this.user}) : super(key: key);
  final BasicUser user;
  @override
  State<UserContainer> createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  bool already_saved = false, isLoading = false;
  var _image;

  void loadPhoto() async {
    print(widget.user.photo);
    if (widget.user.photo == "" || widget.user.photo == null) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    _image = await FileConverter.getImageFromBase64(widget.user.photo!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading && _image == null) {
      loadPhoto();
    }
    return InkWell(
        onTap: () async {
          User u = await HttpService.shared.getUser(widget.user.username!);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(user: u)),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          color: Colors.transparent,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              decoration: BoxDecoration(
                  color: MyColors.lightGreen,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: _image != null
                        ? Image.file(
                            _image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.fitHeight,
                          )
                        : (isLoading
                            ? CircularProgressIndicator()
                            : CircleAvatar(
                                backgroundColor: MyColors.red,
                                child: Text("image"),
                                radius: 30,
                              )),
                  ),
                  Text(widget.user.username!),
                ],
              )),
        ));
  }
}
