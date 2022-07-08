import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(TripScreen());

class TripScreen extends StatefulWidget {

  TripScreen({Key key, this.title})
      : super(key: key);

  final String title;

  @override
  _TripScreenPageState createState() => _TripScreenPageState();
}

class _TripScreenPageState extends State<TripScreen> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Trips', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
          ],
        ),
      ),
    );
  }


  


}