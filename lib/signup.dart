import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'Networking/ApiURLs.dart';
import 'login.dart';


void main() => runApp(SignUp());

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


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

  Widget _entryFieldUserName(String title, {bool isUserName = false}) {
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
              obscureText: isUserName,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Enter Username',
                  // hintStyle: TextStyle( color: Colors.white),

                  prefixIcon: Icon(Icons.person),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none,),
                  fillColor: Colors.white30,
                  filled: true)),

        ],
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

  Widget _GenderText() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "    Gender",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xfff79c4f)),
          ),


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
      child: Text(
        'Sign Up Now',
        style: TextStyle(fontSize: 20, color: Colors.white),
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
        _entryFieldUserName("    User Name"),
        _entryFieldMail("    Email"),
        _entryField("    Password", isPassword: true),
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
                      SizedBox(height: 2),

                      _GenderText(),

                      _RadioBtn(),
                      SizedBox(height: 20),
                      _submitButton(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }


  Future<dynamic> SignUpuser(String email,String password, String gender, String name) async{
    var url = MyVector().baseUrl+ApiEndPoints().Register;

    var data = json.encode(
        {
          apiParameters().email: email,
          apiParameters().password:password,
          apiParameters().loginDevice: 1.toString(),
          apiParameters().name: name
        });
    var response = await http.post(url, headers: {header().contentType: header().applicationjson},body: data);
    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);
     // bodyJson =  login_Model.fromJson(newBody);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );

    } else {
      print(response.statusCode);
    }
  }



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

                value: 1, groupValue: 'null', onChanged: (index) {


            }),
            Expanded(child: Text('Male',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white)))
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: Row(
          children: [
            Radio(
                value: 1, groupValue: 'null', onChanged: (index) {}),
            Expanded(child: Text('Female',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white)))
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: Row(
          children: [
            Radio(
                value: 1, groupValue: 'null', onChanged: (index) {}),
            Expanded(
              child: Text('Other',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.white)),
            )
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
        fit: BoxFit.fill,
      ),

    ],
  );
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

              // child: _bottomLoginSignUpBtn(),

            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // _buildLoginPage()



              ],
            )

          ],
        ),
      ),
    );
  }
}