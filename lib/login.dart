import 'dart:async';
import 'dart:convert';
import 'dart:convert';


import 'dart:io';



import 'package:adequate_travel_app/Models/login_model.dart';
import 'package:adequate_travel_app/login.dart';
import 'package:adequate_travel_app/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:toast/toast.dart';
import 'dart:math';

import 'package:adequate_travel_app/Networking/WebRequester.dart';
import 'package:adequate_travel_app/Networking/ApiURLs.dart';
import 'Utils/new_tab_bar.dart';
import 'forgot_password.dart';



void main() => runApp(Login());

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<Login> {

  var bodyJson = login_Model();


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xfff79c4f)))
          ],
        ),
      ),
    );
  }


  Widget _entryFieldMail(String title, {bool isMail = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xfff79c4f)),
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
                    borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none,),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xfff79c4f)),
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
                      borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none,),
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

              colors: [Color(0xFF2196F3),Color(0xFF2196F3)])),
    child: FlatButton(
      color: Color(0xFF2196F3),
    onPressed: () {

      loginuser(nameController.text.trim(),passwordController.text.trim());





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

  @override
  Widget _RadioBtn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio(
                  // value:radioController.text,


                  value: 1, groupValue: '', onChanged: (radioController) {

              }),
              Expanded(child: Text('Keep me Signed In',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Color(0xfff79c4f))))
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget _userImage(){
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
            ],
          ),
        ));
  }


  Future<dynamic> loginuser(String email,String password) async{
    var url = MyVector().baseUrl+ApiEndPoints().Login;

    var data = json.encode(
        {
          apiParameters().email: email,
          apiParameters().password:password,
          apiParameters().loginDevice: 1.toString()
        });
    var response = await http.post(url, headers: {header().contentType: header().applicationjson},body: data);
    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);
       bodyJson =  login_Model.fromJson(newBody);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => newTabBar()),
      );

    } else {
      print(response.statusCode);
    }
  }
}

@override
Widget _logoContainer(){
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
              children: <Widget>[
              ],
            )
          ],
        ),
      ),
    );
  }
}






















