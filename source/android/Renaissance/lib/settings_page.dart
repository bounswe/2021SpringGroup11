import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/login_page.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/my_paths_page.dart';
import 'package:portakal/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

@visibleForTesting
class SettingsPageState extends State<SettingsPage> {
  bool allowNotifications = true;
  bool favoritePaths = true;
  bool enrolledPaths = true;
  bool favoriteTopics = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.blue,
          title: Text("Settings"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: allowNotifications
                            ? BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))
                            : BorderRadius.all(Radius.circular(15)),
                        color: MyColors.lightGreen),
                    child: Row(
                      children: [
                        Icon(Icons.circle_notifications, color: MyColors.blue),
                        SizedBox(width: 20),
                        Text(
                          "Allow notifications",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                        Spacer(),
                        CupertinoSwitch(
                            value: allowNotifications,
                            onChanged: (value) {
                              setState(() {
                                allowNotifications = value;
                              });
                            })
                      ],
                    ),
                  ),
                  Container(
                      padding: allowNotifications
                          ? EdgeInsets.symmetric(vertical: 3, horizontal: 10)
                          : EdgeInsets.all(0),
                      color: MyColors.blue,
                      child: allowNotifications
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Favorite Paths",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    CupertinoSwitch(
                                        value: favoritePaths,
                                        onChanged: (value) {
                                          setState(() {
                                            favoritePaths = value;
                                          });
                                        })
                                  ],
                                )
                              ],
                            )
                          : Container(
                              height: 0,
                            )),
                  Container(
                    padding: allowNotifications
                        ? EdgeInsets.symmetric(vertical: 3, horizontal: 10)
                        : EdgeInsets.all(0),
                    color: MyColors.blue,
                    child: allowNotifications
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text("Enrolled Paths",
                                      style: TextStyle(fontSize: 15)),
                                  Spacer(),
                                  CupertinoSwitch(
                                      value: enrolledPaths,
                                      onChanged: (value) {
                                        setState(() {
                                          enrolledPaths = value;
                                        });
                                      })
                                ],
                              )
                            ],
                          )
                        : Container(
                            height: 0,
                          ),
                  ),
                  Container(
                    padding: allowNotifications
                        ? EdgeInsets.symmetric(vertical: 3, horizontal: 10)
                        : EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(15)),
                        color: MyColors.blue),
                    child: allowNotifications
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text("Favorite Topics",
                                      style: TextStyle(fontSize: 15)),
                                  Spacer(),
                                  CupertinoSwitch(
                                      value: favoriteTopics,
                                      onChanged: (value) {
                                        setState(() {
                                          favoriteTopics = value;
                                        });
                                      })
                                ],
                              )
                            ],
                          )
                        : Container(
                            height: 0,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPathsPage()));
              },
              child: Row(
                children: [
                  Icon(Icons.access_time_outlined, color: MyColors.blue),
                  SizedBox(width: 20),
                  Text("My Paths",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal))
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              color: MyColors.lightGreen,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {
                _displayPasswordDialog(context);
              },
              child: Row(
                children: [
                  Icon(Icons.vpn_key, color: MyColors.blue),
                  SizedBox(width: 20),
                  Text("Change Password",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal))
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              color: MyColors.lightGreen,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await Future.wait(
                    [prefs.remove('isLoggedIn'), prefs.remove('token')]);
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    PageRouteBuilder(pageBuilder: (
                      BuildContext context,
                      Animation animation,
                      Animation secondaryAnimation,
                    ) {
                      return LoginPage();
                    }, transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return new SlideTransition(
                        position: new Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    }),
                    (Route route) => false);
              },
              child: Row(
                children: [
                  Icon(Icons.logout, color: MyColors.red),
                  SizedBox(width: 10),
                  Text("Logout",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: MyColors.red))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              color: MyColors.pink,
              padding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            )
          ],
          padding: EdgeInsets.only(top: 100, right: 20, left: 20),
        ));
  }

  Future<void> _displayPasswordDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Change your password"),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _oldPasswordController,
                    decoration: InputDecoration(hintText: "Old Password"),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(hintText: "New Password"),
                    obscureText: true,
                    validator: (val) {
                      if (val!.length < 5)
                        return 'Length must be at least 5 characters.';
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.always,
                  ),
                  TextFormField(
                    controller: _repeatController,
                    decoration:
                        InputDecoration(hintText: "Repeat New Password"),
                    obscureText: true,
                    validator: (val) {
                      if (val!.isEmpty) return 'Empty';
                      if (val.compareTo(_passwordController.text) != 0)
                        return 'Passwords must match.';
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.always,
                  )
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing data')));
                    try {
                      var response = await HttpService.shared
                          .changePassword(_passwordController.text);
                    } on Exception catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    }
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form not valid.')));
                  }
                },
                child: Text("OK"),
                color: Colors.greenAccent,
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                  color: Colors.redAccent)
            ],
          );
        });
  }
}
