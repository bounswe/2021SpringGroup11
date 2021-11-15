import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portakal/http_services.dart';
import 'package:portakal/login_page.dart';
import 'my_colors.dart';

// TODO: Password validation
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";
  String username = "";
  String password = "";
  String repeatedPassword = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4.1,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [MyColors.red, MyColors.red],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(90),
                            bottomRight: Radius.circular(70))),
                    child: Image(image: AssetImage('assets/logo.png'))),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                    flex: 2,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _emailTextField(),
                            _usernameTextField(),
                            _firstNameTextField(),
                            _lastNameTextField(),
                            _passwordTextField(),
                            _repeatPasswordTextField(),
                            SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 200,
                                  height: 45,
                                  padding: EdgeInsets.only(left: 20, right: 30),
                                  child: _registerButton(),
                                ))
                          ],
                        ),
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    //padding: EdgeInsets.only(top: 40),
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [MyColors.lightGreen, MyColors.lightGreen],
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: _loginButton(),
                      alignment: Alignment.center,
                    ))
              ],
            ),
          )),
    );
  }

  Widget _loginButton() => ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Have an account? Log in.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
        style: ElevatedButton.styleFrom(
            primary: MyColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            )),
      );

  Widget _emailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      style: TextStyle(
          color: Color(0xff3c3c3c),
          fontSize: 18.0,
          fontWeight: FontWeight.w700),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(40)),
          icon: Icon(
            Icons.mail,
            color: Colors.black,
          ),
          hintText: 'E-mail',
          filled: true,
          fillColor: Colors.black.withOpacity(0.1),
          contentPadding: EdgeInsets.symmetric(horizontal: 10)),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      style: TextStyle(
          color: Color(0xff3c3c3c),
          fontSize: 18.0,
          fontWeight: FontWeight.w700),
      controller: usernameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(40)),
        icon: Icon(
          Icons.alternate_email,
          color: Colors.black,
        ),
        hintText: 'Username',
        filled: true,
        fillColor: Colors.black.withOpacity(0.1),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(
          color: Color(0xff3c3c3c),
          fontSize: 18.0,
          fontWeight: FontWeight.w700),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(40)),
          icon: Icon(Icons.vpn_key, color: Colors.black),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: Colors.black.withOpacity(0.1),
          hintText: 'Password'),
      controller: passwordController,
      validator: (password) {
        if (password!.length < 5) {
          return 'Password must be at least 5 characters';
        }
      },
    );
  }

  Widget _firstNameTextField() {
    return TextFormField(
        controller: firstNameController,
        style: TextStyle(
            color: Color(0xff3c3c3c),
            fontSize: 18.0,
            fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(40)),
          icon: Icon(Icons.person, color: Colors.black),
          hintText: 'First Name',
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: Colors.black.withOpacity(0.1),
        ));
  }

  Widget _lastNameTextField() {
    return TextFormField(
        controller: lastNameController,
        style: TextStyle(
            color: Color(0xff3c3c3c),
            fontSize: 18.0,
            fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(40)),
          icon: Icon(Icons.person, color: Colors.black),
          hintText: 'Last Name',
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: Colors.black.withOpacity(0.1),
        ));
  }

  Widget _repeatPasswordTextField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(
          color: Color(0xff3c3c3c),
          fontSize: 18.0,
          fontWeight: FontWeight.w700),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(40)),
          icon: Icon(
            Icons.vpn_key,
            color: Colors.black,
          ),
          hintText: 'Repeat Password',
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          fillColor: Colors.black.withOpacity(0.1)),
      validator: (password) {
        if (password != passwordController.text) {
          return 'Passwords must match';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.always,
    );
  }

  Future<void> _invalidRegister(Exception error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(error.toString()),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Error!"),
                Text('Press back button to direct to the register page.'),
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

  Future<void> _validRegister() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Succesful Register'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Successfully registered! '),
                Text('Check your email to validate your account.'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName("/"));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _registerButton() => ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate() == false || _isLoading) { return; }
          try {
            setState(() {
              _isLoading = true;
            });
            bool result = await HttpService.shared.register(
                emailController.text,
                usernameController.text,
                firstNameController.text,
                lastNameController.text,
                passwordController.text);
            setState(() {
              _isLoading = false;
            });
            if (result) {
              _validRegister();
            } else {}
          } on Exception catch (error) {
            setState(() {
              _isLoading = false;
            });
            _invalidRegister(error);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Register",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            _isLoading ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ) : Icon(Icons.arrow_forward_sharp, color: Colors.white),
          ],
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.black54)),
            padding: EdgeInsets.all(10),
            primary: MyColors.darkGray),
      );
}
