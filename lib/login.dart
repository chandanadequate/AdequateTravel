// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'package:adequate_travel_app/Utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:adequate_travel_app/Models/login_model.dart';
import 'package:adequate_travel_app/menu_screen.dart';

import 'package:adequate_travel_app/Networking/ApiURLs.dart';

import 'forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

void main() => runApp(Login());

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  // AnimationController controller;
  bool isLoading = false;
  var bodyJson = login_Model();
  bool _isChecked = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )..addListener(() {
    //     setState(() {});
    // });

    // controller.repeat(reverse: true);

    super.initState();
    _loadUserEmailPassword();
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => MyAppp()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Color(0xfff79c4f)),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xfff79c4f)))
          ],
        ),
      ),
    );
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', nameController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  Widget _entryFieldMail(String title, {bool isMail = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xfff79c4f)),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: nameController,
              obscureText: isMail,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Enter Email',

                  // hintStyle: TextStyle( color: Colors.white),

                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white30,
                  filled: true)),
        ],
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xfff79c4f)),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: passwordController,
              obscureText: isPassword,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Enter Password',
                  //hintStyle: TextStyle( color: Colors.white),

                  prefixIcon: Icon(Icons.lock_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white30,
                  filled: true)),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //       color: Colors.grey.shade200,
          //       offset: Offset(2, 4),
          //       blurRadius: 5,
          //       spreadRadius: 2)
          // ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF2196F3), Color(0xFF2196F3)])),
      child: FlatButton(
        color: Color(0xFF2196F3),
        onPressed: () {
          setState(() {
            isLoading = true;
          });

          if (nameController.text != null && passwordController.text != null) {
            loginuser(nameController.text.trim(),
                passwordController.text.trim(), _isChecked);
          } else {
            Alerti.showAlertDialog(
                context, 'Alert', 'Please Provide email and Password');
          }
        },
        child: Text(
          'Sign In Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ForgotPassword()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(1),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Forgot Password ?',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _title() {
  //   return RichText(
  //     textAlign: TextAlign.center,
  //     text: TextSpan(
  //         text: 'd',
  //         style: TextStyle(
  //             fontSize: 30,
  //             fontWeight: FontWeight.w700,
  //             color: Color(0xffe46b10)
  //         ),
  //         children: [
  //           TextSpan(
  //             text: 'ev',
  //             style: TextStyle(color: Colors.black, fontSize: 30),
  //           ),
  //           TextSpan(
  //             text: 'rnz',
  //             style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
  //           ),
  //         ]),
  //   );
  // }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldMail("    Email"),
        _entryField("    Password", isPassword: true),
      ],
    );
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        nameController.text = _email ?? "";
        passwordController.text = _password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget _RadioBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Checkbox(
                  activeColor: Colors.orange,
                  value: _isChecked,
                  onChanged: (index) {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                  }),
              Expanded(
                  child: Text('Keep me Signed In',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Color(0xfff79c4f))))
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget _userImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/login_user.png'),
          alignment: Alignment.topCenter,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/back_screen.png'),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .1),
                      _logoContainer(),
                      _userImage(),
                      SizedBox(height: 10),
                      _emailPasswordWidget(),
                      _RadioBtn(),
                      SizedBox(height: 20),
                      _submitButton(),
                      _divider(),
                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
              (isLoading)
                  ? Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black45,
                        child: Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }

  Future<dynamic> loginuser(String email, String password, bool ischeck) async {
    isLoading = true;
    var url = MyVector().baseUrl + ApiEndPoints().Login;
    var data = json.encode({
      apiParameters().email: email,
      apiParameters().password: password,
      apiParameters().loginDevice: 1.toString()
    });

    var response = await http.post(Uri.parse(url),
        headers: {header().contentType: header().applicationjson}, body: data);
    isLoading = false;

    setState(() {
      if (response.statusCode == 200) {
        var newBody = json.decode(response.body);
        bodyJson = login_Model.fromJson(newBody);

        String myId = bodyJson.id.toString();
        String nameOfUser = bodyJson.name.toString();
        String userImage = bodyJson.profilePicture.toString();
        String token = bodyJson.token.toString();
        print(token);

        if (ischeck) {
          SharedPreferences.getInstance().then(
            (prefs) {
              prefs.setString('email', email);
              prefs.setString('password', password);
              prefs.setString('MyID', myId);
              prefs.setString('userImage', userImage);
              prefs.setString('Name', nameOfUser);
              prefs.setString('token', token);
            },
          );
        }

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MenuScreen(
                id: bodyJson.id,
                imageUrl: bodyJson.profilePicture,
                NameUser: bodyJson.name)));
      } else {
        print(response.statusCode);
        Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
      }
    });
  }
}

@override
Widget _logoContainer() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image(
        image: AssetImage('assets/images/logo.png'),
        alignment: Alignment.topCenter,
        height: 100.0,
        width: 360.0,
      ),
    ],
  );
}

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 10.0,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    Pattern pattern =
        '^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }
}
