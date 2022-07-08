import 'package:adequate_travel_app/faq_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      new MaterialApp(
        home: new HelpPage(),
        debugShowCheckedModeBanner: false,
      ),
    );

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => new _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('FAQ', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
            // color: Colors.black38,
            child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, i) {
                  return new ExpansionTile(
                    backgroundColor: Colors.orange.shade700,
                    title: new Text(
                      vehicles[i].title,
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                    children: <Widget>[
                      new Column(
                        children: _buildExpandableContent(vehicles[i]),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: _submitButton(),
            ),
          ],
        )));
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

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          title: new Text(
            content,
            style: new TextStyle(fontSize: 18.0),
          ),
        ),
      );
    return columnContent;
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
              colors: [Colors.blue, Colors.blue])),
      child: FlatButton(
        color: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => FaqScreen()),
          );
        },
        child: Text(
          'ASK YOUR QUERIES',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];
  //final IconData icon;

  Vehicle(this.title, this.contents);
}

List<Vehicle> vehicles = [
  new Vehicle(
    'HOW TO VERIFY MY ACCOUNT',
    [
      'When you register an account on Adequate travel, one OTP mail is sent to your email address. Enter this OTP to register.'
    ],
  ),
  new Vehicle(
    'HOW TO CONNECT WITH TRAVEL CHUMPS NEARBY',
    [
      'If you want to meet all those travel chumps who are nearby your current location, simply click on people nearby and see the list of travel chumps'
    ],
    //Icons.directions_car,
  ),
  new Vehicle(
    'HOW TO INVITE TRAVEL CHAUMPS FOR TRIPS',
    [
      'Want to enjoy your trip with new travel champs, so invite others travel champs on your trips, go to create trip, filled the details and requirement about your preferences and post the trip. then see the list of people who are interested to join you.'
    ],
  ),
  new Vehicle(
    'HOW TO POST YOUR EXPERIENCE',
    [
      'Want to share your trip experience. Go to create your trip experience, enters the details with images with images or videos and shares with others travel chaumps'
    ],
  ),
  new Vehicle(
    'HOW TO UPLOAD VIDEO OF OUR EXPERIENCE ?',
    [
      'Go to post your video, add the details, enter the Youtube link and post your experience.'
    ],
  ),
  new Vehicle(
    'WHAT IS MY RECENT ACTIVITY ?',
    [
      'My recent activities shows you about the recent activities of user like, commnet, post, like, showing interest etc.'
    ],
  ),
  new Vehicle(
    'WHAT DOCUMENT REQUIRED WHEN APPLY FOR CASHBACK?',
    [
      'No extra documents required just filled the form and attach the soft copy of your invoice'
    ],
  ),
  new Vehicle(
    'WHAT IS A TRAVEL GUIDE? HOW DOES IT HELP ME ON MY TRIPS?',
    [
      'As it${"'"}s impossible to know every city or country to its core that you are visiting or you dream to visit in future. Therefore, we are bringing you the fresh and informative blogs that are written by our young travel guides to help you explore the city in its depth. We also have an interactive comment section where you can ask any query without any hesitation as we don${"'"}t judge we let you explore.'
    ],
  ),
  new Vehicle(
    'WHERE I CAN SEE MY CASHBACK STATUS?',
    [
      'Go to the dashboard and click on the booking option. Here you can see all your claim booking request with their cashback status.'
    ],
  ),
  new Vehicle(
    'WHAT IS THE E-MAIL ADDRESS OF THE SUPPORT TEAM?',
    [
      'If you have any questions or any issue related to our app or your booking, please connect with us at contact@adequateinfosoft.com'
    ],
  ),
  new Vehicle(
    'HOW ADEQUATE TRAVEL IS DIFFERENT FROM OTHERS?',
    [
      'No more bargaining as now you can earn your own discounts with the help of this incredible feature in our app that you won${"'"}t find anywhere else. This feature works over your activities of social networking on our travel community explained as par. After posting a photo, sharing any essential travelling experience, Liking, Commenting, Sharing, or Making Friends will reward you points that you can convert into discount figures that we provide on your bookings without any extra conditions. You can get instant Hotel, Flight, and Package discounts through these points by using the Redeem Now option in our app.'
    ],
  ),
];
