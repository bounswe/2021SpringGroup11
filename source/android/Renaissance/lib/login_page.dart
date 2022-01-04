import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portakal/bottom_navigation_page.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/register_page.dart';
import 'package:portakal/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_services.dart';
import 'models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

@visibleForTesting
class LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: ListView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.4,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [MyColors.lightGreen, MyColors.lightGreen],
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(90),
                              bottomRight: Radius.circular(70))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Align(
                                alignment: Alignment.center,
                                child: Image(
                                    image: AssetImage('assets/logo.png'))),
                            Spacer(),
                          ])),
                  Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 100),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                style: TextStyle(
                                    color: Color(0xff3c3c3c),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    icon: Icon(
                                      Icons.alternate_email,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Username',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.1)),
                                validator: (username) {
                                  //Check if username address is valid here, if invalid, return a message.
                                  if (username == null ||
                                      username.length == 0) {
                                    return "Username cannot be empty !";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  username = value!.trim();
                                },
                              ),
                              TextFormField(
                                obscureText: !_passwordVisible,
                                style: TextStyle(
                                    color: Color(0xff3c3c3c),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    icon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Password',
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.1),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10)),
                                validator: (password) {
                                  if (password!.length == 0) {
                                    return "Password cannot be empty !";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value!.trim();
                                },
                              ),
                              SizedBox(height: 40),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 150,
                                    height: 45,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 30),
                                    child: _loginButton(),
                                  ))
                            ],
                          ),
                        ),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4.5,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [MyColors.red, MyColors.red],
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _forgotPasswordButton(),
                            _signupButton(),
                          ])),
                ])));
  }

  Widget _signupButton() => ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: Text('Register',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
        style: ElevatedButton.styleFrom(
            primary: MyColors.lightGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.red))),
      );

  Widget _forgotPasswordButton() => ElevatedButton(
        onPressed: () {
          _displayForgotPasswordDialog(context);
        },
        child: Text('Forgot Password?',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
        style: ElevatedButton.styleFrom(
            primary: MyColors.lightGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.red))),
      );

  Future<void> _displayForgotPasswordDialog(BuildContext context) async {
    String username = "";
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Forgot Password?"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Enter your username"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    onChanged: (value) {
                      username = value;
                    },
                    placeholder: "Username",
                  ),
                )
              ],
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                  color: Colors.red),
              MaterialButton(
                  onPressed: () async {
                    if (username.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Username cant be empty !',
                          style: TextStyle(
                              decorationColor: Colors.greenAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ));
                      return;
                    }
                    bool success =
                        await HttpService.shared.forgotPassword(username);
                    if (success) {
                      print("success");
                    }
                    Navigator.pop(context);
                  },
                  child: Text("Send mail"),
                  color: Colors.green),
            ],
          );
        });
  }

  Widget _loginButton() => ElevatedButton(
        onPressed: () async {
          if (_isLoading) return;
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            try {
              setState(() {
                _isLoading = true;
              });
              List responses = await Future.wait([
                HttpService.shared.login(username, password),
                HttpService.shared.getUser(username)
              ]);
              setState(() {
                _isLoading = false;
              });
              User.me = responses[1];
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', true);
              Navigator.pop(context);
              Navigator.pushNamed(context, "/home");
            } on Exception catch (error) {
              setState(() {
                _isLoading = false;
              });
              _invalidLogin(error);
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            _isLoading
                ? Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Icon(
                    CupertinoIcons.arrow_right_circle_fill,
                    color: Colors.white70,
                  ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.black54)),
            padding: EdgeInsets.all(10),
            primary: MyColors.darkGray),
      );

  Future<void> _invalidLogin(Exception error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(error.toString().substring(11, error.toString().length)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Press try again with valid information'),
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
}
