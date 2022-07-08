// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:adequate_travel_app/Networking/ApiURLs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(accountSetting());

class accountSetting extends StatefulWidget {
  accountSetting({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _accountSettingPageState createState() => _accountSettingPageState();
}

class _accountSettingPageState extends State<accountSetting> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('ACCOUNT SETTINGS', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                _titleHeading(),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _emailPasswordWidget(),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _submitButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleHeading() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Change Password',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryFieldOldPassword("    Old Password"),
        _entryFieldNewPassword("    New Password"),
        _entryFieldConfirmNewPassword("   Confirm New Password",
            isPassword: true),
      ],
    );
  }

  Widget _entryFieldOldPassword(String title, {bool isMail = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: oldPassword,
              obscureText: isMail,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Old Password',
                  // hintStyle: TextStyle( color: Colors.white),

                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true)),
        ],
      ),
    );
  }

  Widget _entryFieldNewPassword(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: newPassword,
              obscureText: isPassword,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'New Password',
                  //hintStyle: TextStyle( color: Colors.white),

                  prefixIcon: Icon(Icons.lock_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true)),
        ],
      ),
    );
  }

  Widget _entryFieldConfirmNewPassword(String title,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 15, color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: confirmNewPassword,
              obscureText: isPassword,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Confirm New Password',
                  //hintStyle: TextStyle( color: Colors.white),

                  prefixIcon: Icon(Icons.lock_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true)),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.orange, Colors.orange])),
      child: FlatButton(
        color: Colors.orange,
        onPressed: () {
          // loginuser(nameController.text.trim(), passwordController.text.trim(),_isChecked);
        },
        child: Text(
          'Save Changes',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Future<dynamic> ResetPassword(
      String oldPass, String newPass, String ConfirmPass) async {
    var url = MyVector().baseUrl + ApiEndPoints().ResetPassword;

    var data = json.encode({
      apiParameters().newpassword: newPass,
      apiParameters().currentPassword: oldPass,
    });
    var response = await http.post(Uri.parse(url),
        headers: {header().contentType: header().applicationjson}, body: data);
    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);

      //bodyJson = login_Model.fromJson(newBody);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MenuScreen() ),
      // );
      //

    } else {
      print(response.statusCode);
    }
  }
}
