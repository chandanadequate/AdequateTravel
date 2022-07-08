import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'main_screen.dart';
import 'package:image/image.dart' as Images;
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  Set<Marker> markers_ = {};
  int refreshFlag = 1;

  Future<List<int>> makeReceiptImage(pf) async {
    var data = await http.get(Uri.parse(
        'https://i.insider.com/5c16ac5bdde8676d8d340d02?width=1101&format=jpeg'));
    ByteData imageData;
    List<int> bytes = data.bodyBytes;
    var avatarImage = Images.decodeImage(bytes);

    imageData = await rootBundle.load('assets/images/marker.png');
    bytes = Uint8List.view(imageData.buffer);

    var markerImage = Images.decodeImage(bytes);
    avatarImage = Images.copyResize(avatarImage, width: 500, height: 360);
    var radius = 150;
    int originX = avatarImage.width ~/ 2, originY = avatarImage.height ~/ 2;
    for (int y = -radius; y <= radius; y++)
      for (int x = -radius; x <= radius; x++)
        if (x * x + y * y <= radius * radius)
          markerImage.setPixelSafe(originX + x + 8, originY + y + 10,
              avatarImage.getPixelSafe(originX + x, originY + y));

    markerImage = Images.copyResize(markerImage, width: 70, height: 70);
    return Images.encodePng(markerImage);
  }

  @override
  void initState() {
    super.initState();
  }

  addMarker() async {
    var tmp = await makeReceiptImage("");
    markers_.add(
      Marker(
        markerId: MarkerId('Marker'),
        position: LatLng(37.42796133580664, -122.085749655962),
        infoWindow: InfoWindow(title: "title of marker"),
        icon: BitmapDescriptor.fromBytes(tmp),
      ),
    );
    setState(() {
      refreshFlag++;
    });
  }

  @override
  Widget build(BuildContext context) {
    addMarker();
    return Container(
      child: GoogleMap(
        myLocationEnabled: true,
        markers: markers_,
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.4746,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyAppp())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Image(
          image: AssetImage(
            'assets/images/WelcomeSplash.png',
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ));
  }
}
