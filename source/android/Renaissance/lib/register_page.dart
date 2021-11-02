
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget> [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.4,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            MyColors.red,
                            MyColors.red
                          ],
                        ),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90), bottomRight: Radius.circular(70))
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Align(alignment: Alignment.center,
                              child: Image(image: AssetImage('assets/logo.png'))),
                          Spacer(),
                        ]
                    )
                ),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _emailTextField(),
                      _usernameTextField(),
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
                        )
                      )
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            MyColors.lightGreen,
                            MyColors.lightGreen
                          ],
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      alignment: Alignment.center,
                      child: _loginButton()
                    )
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _loginButton() =>  ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text('Have an account? Log in.', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
    style: ElevatedButton.styleFrom(
        primary: MyColors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
        )
    ),
  );

  Widget _emailTextField() {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      height: 54,
      padding: EdgeInsets.only(
          top: 6,left: 16, right: 16, bottom: 4
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(50)
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      child: TextField(
        style: TextStyle(color: Color(0xff3c3c3c), fontSize: 18.0, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.mail,
            color: Colors.black,
          ),
          hintText: 'E-mail',
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      height: 54,
      padding: EdgeInsets.only(
          top: 6,left: 16, right: 16, bottom: 4
      ),
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(50)
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      child: TextField(
        style: TextStyle(color: Color(0xff3c3c3c), fontSize: 18.0, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.alternate_email,
            color: Colors.black,
          ),
          hintText: 'Username',
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      height: 54,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(
          top: 6,left: 16, right: 16, bottom: 4
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(50)
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Color(0xff3c3c3c), fontSize: 18.0, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.vpn_key,
              color: Colors.black,
            ),
            hintText: 'Password',
        ),
      ),
    );
  }

  Widget _repeatPasswordTextField() {
    return Container(
      width: MediaQuery.of(context).size.width/1.2,
      height: 54,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(
          top: 6,left: 16, right: 16, bottom: 4
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(50)
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Color(0xff3c3c3c), fontSize: 18.0, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.vpn_key,
            color: Colors.black,
          ),
          hintText: 'Repeat Password',
        ),
      ),
    );
  }

  Widget _registerButton() => ElevatedButton(onPressed: (){},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Register",
          style: TextStyle(
              fontSize: 19.0,
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),
        ),
        Icon(Icons.arrow_forward_sharp, color: Colors.white),
      ],
    ),
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.black54)
        ),
        padding: EdgeInsets.all(10),
        primary: MyColors.darkGray
    ),
  );
}

