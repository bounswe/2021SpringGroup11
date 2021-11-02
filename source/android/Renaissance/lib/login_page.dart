import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
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
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3.4,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  MyColors.lightGreen,
                                  MyColors.lightGreen
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
                          padding: EdgeInsets.only(top: 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
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
                              ),
                              Container(
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
                                  obscureText: !_passwordVisible,
                                  style: TextStyle(color: Color(0xff3c3c3c), fontSize: 18.0, fontWeight: FontWeight.w700),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.vpn_key,
                                        color: Colors.black,
                                      ),
                                      hintText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 150,
                                    height: 45,
                                    padding: EdgeInsets.only(left: 20, right: 30),
                                    child: _loginButton(),
                                  )
                              )
                            ],
                          )
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4.5,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  MyColors.red,
                                  MyColors.red
                                ],
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _forgotPasswordButton(),
                                _signupButton(),
                              ]
                          )
                      ),
                    ]
                )
            )
        )
    );
  }

  Widget _signupButton() =>  ElevatedButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
    },
    child: Text('Register', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
    style: ElevatedButton.styleFrom(
        primary: MyColors.lightGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.red)
        )
    ),
  );

  Widget _forgotPasswordButton() => ElevatedButton(
    onPressed: () {},
    child: Text('Forgot Password?', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400)),
    style: ElevatedButton.styleFrom(
        primary: MyColors.lightGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.red)
        )
    ),
  );

  Widget _loginButton() => ElevatedButton(onPressed: (){
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint("username: $email, password: $password");
      showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hata"),
          content: Text("Giris bilgileriniz hatali"),
          actions: [MaterialButton(onPressed: () => Navigator.pop(context), child: Text("back"),)],);
      });
    }
  }, child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text("Login",
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
