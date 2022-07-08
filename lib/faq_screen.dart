import 'dart:convert';
import 'package:adequate_travel_app/Networking/ApiURLs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Utils/alert.dart';

void main() => runApp(FaqScreen());

class FaqScreen extends StatefulWidget {
  FaqScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FaqScreenPageState createState() => _FaqScreenPageState();
}

class _FaqScreenPageState extends State<FaqScreen> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('FAQ', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/splashPlain.png'),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            HeadingText(),
                            MessageContainer(),
                            SizedBox(height: 10),
                            _submitButton()
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'YOU AN ALSO CONNECT WITH US ON',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            phoneNumber(),
                            Contact(),
                            SizedBox(height: 5),
                            Address(),
                            SizedBox(height: 5),
                            _divider(),
                            SizedBox(height: 5),
                            IconsData()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget HeadingText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Have Any Questions?',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            'We love to hear from you',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget phoneNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.phone, color: Colors.blue),
        Text.rich(
          TextSpan(
            text: '+91-0120-4198878',
          ),
        ),
      ],
    );
  }

  Widget Contact() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.mail, color: Colors.blue),
        Text.rich(
          TextSpan(
            text: 'contact@adequateinfosoft.com',
          ),
        ),
      ],
    );
  }

  Widget Address() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: Colors.blue),
        Text.rich(
          TextSpan(
            text: 'H-15, Sector-63, Noida, In 201301',
          ),
        ),
      ],
    );
  }

  Widget IconsData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(image: AssetImage('assets/images/4.png')),
        SizedBox(width: 5),
        Image(image: AssetImage('assets/images/5.png')),
        SizedBox(width: 5),
        Image(image: AssetImage('assets/images/6.png')),
        SizedBox(width: 5),
        Image(image: AssetImage('assets/images/7.png')),
        SizedBox(width: 5),
        Image(image: AssetImage('assets/images/8.png')),
      ],
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

  Widget MessageContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                TextFormField(
                  maxLines: 10,
                  controller: message,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Leave a Message for us...',
                    hintTextDirection: TextDirection.ltr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 5.0,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF2196F3), Color(0xFF2196F3)])),
      child: FlatButton(
        onPressed: () {
          setState(() {
            SendUserMsg('email', 'name', 'phone', 'query');
          });
        },
        child: Text(
          'Send a Message',
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<dynamic> SendUserMsg(
      String email, String name, String phone, String query) async {
    var url = MyVector().baseUrl + ApiEndPoints().PostContactus;
    var data = json.encode({
      apiParameters().email: email,
      apiParameters().name: name,
      apiParameters().phone: phone,
      apiParameters().query: query
    });

    var response = await http.post(Uri.parse(url),
        headers: {header().contentType: header().applicationjson}, body: data);
    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);
      print(newBody);

      Alerti.showAlertDialog(
          context, 'Great', 'Thank you for your valuable feedBack');
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
    }
  }
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
