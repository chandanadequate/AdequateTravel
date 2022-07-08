import 'dart:convert';
import 'package:adequate_travel_app/Models/login_model.dart';
import 'package:adequate_travel_app/Networking/ApiURLs.dart';
import 'package:adequate_travel_app/login.dart';
import 'package:adequate_travel_app/menu_screen.dart';
import 'package:adequate_travel_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:adequate_travel_app/main_screen.dart';

import 'Utils/alert.dart';

void main() => runApp(MyAppp());

class MyAppp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
    // Theme(
    //   data: ThemeData(
    //     accentColor: mainColor,
    //   ),
    //   child: FloatingActionButton(
    //     onPressed: () {},
    //     child: Icon(Icons.person),
    //   ),
    // );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var isLoading = false;
  void checkAuth() async {
    var value = await SharedPreferences.getInstance();
    //value.clear();
    var d = value.get("email");
    if (d != null) {
      var url = MyVector().baseUrl + ApiEndPoints().Login;

      var data = json.encode({
        apiParameters().email: value.get("email"),
        apiParameters().password: value.get("password"),
        apiParameters().loginDevice: 1.toString()
      });

      var response = await http.post(Uri.parse(url),
          headers: {header().contentType: header().applicationjson},
          body: data);
      if (response.statusCode == 200) {
        var bodyJson = login_Model();

        var newBody = json.decode(response.body);
        print(newBody);
        bodyJson = login_Model.fromJson(newBody);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MenuScreen(
                id: bodyJson.id,
                imageUrl: bodyJson.profilePicture,
                NameUser: bodyJson.name)));
      } else {
        Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
        print(response.statusCode);
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text("Forgot Password?"),
        ),
      ],
    );
  }

  Widget _facebookBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50,
          width: 360,
          //margin: EdgeInsets.only(bottom: 40),
          child: RaisedButton(
            elevation: 5.0,
            color: Colors.indigoAccent,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(30.0),
            // ),
            onPressed: () {},
            child: Text(
              "Sign in with Facebook",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 60,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _googleBtn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50,
          width: 360,
          //margin: EdgeInsets.only(bottom: 40),
          child: RaisedButton(
            elevation: 5.0,
            color: Colors.red,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(30.0),
            // ),
            onPressed: () {},
            child: Text(
              "Sign in with Google",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 60,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomLoginSignUpBtn() {
    return Row(
      // : Row(
      children: [
        Material(
          color: Colors.indigoAccent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => SignUp()),
              );
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: 200,
              child: Center(
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            color: Colors.amber,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => Login()),
                );

                //print('called on tap');
              },
              child: const SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      // ),
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OR -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => SignUp()),
              );
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Do not have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _logoContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/logo.png'),
          alignment: Alignment.topCenter,
          height: 200.0,
          width: 360.0,
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              // border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _logoContainer(),
                    _imageSlider(),
                    _facebookBtn(),
                    Padding(
                        padding: EdgeInsets.only(top: 10), child: _googleBtn()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        'assets/images/slideone.png',
        'assets/images/slider_image_two.png',
        'assets/images/slider_image_three.png',
        'assets/images/slider_image_five.png'
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 19.0),
                decoration: BoxDecoration(color: Colors.transparent),
                child: Image(
                  image: AssetImage(i),
                  alignment: Alignment.topCenter,
                ));
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/splashBack.jpg'),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 10.0,
              width: MediaQuery.of(context).size.width,
              child: _bottomLoginSignUpBtn(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
                // Padding(
                //     padding: EdgeInsets.only(bottom: 0),
                //  child:
              ],
            )
          ],
        ),
      ),
    );
  }
}
