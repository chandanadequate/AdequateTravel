import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:adequate_travel_app/Models/peoplenearby_model.dart';
import 'package:adequate_travel_app/Networking/ApiURLs.dart';
import 'package:adequate_travel_app/Utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:image/image.dart' as Images;

//import 'followers_list.dart';

class PeopleNearBy extends StatefulWidget {
  final String title;
  final String id;

  PeopleNearBy({Key key, this.title, this.id}) : super(key: key);

  @override
  _PeopleNearByPageState createState() => _PeopleNearByPageState();
}

class _PeopleNearByPageState extends State<PeopleNearBy> {
  final Set<Marker> markers = new Set();
  Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _filter = new TextEditingController();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  var idd = "0";
  bool flag = false;
  int REFRESHFLAG = 0;
  String userProfileImg = "";
  String userName;
  String locationn = "";
  int totalNearbyCount = 0;
  bool callMe = false;
  bool yo = false;
  String searchString = "";
  bool isSearch = false;
  bool isLoading = true;
  ByteData imageDataa;
  Uint8List forListImageByt;

  var filteredNames = [];
  var peopleName = [];
  var isfollowing = [];
  var distance = [];
  var peopleimage = [];
  var idArray = [];

  double startlt = 0.0;
  double startlng = 0.0;

  double llat = 0.0;
  double lngg = 0.0;
  var nearbyJsonbody = PeopleNearbyModel();
  Set<Marker> markers_ = {};

  @override
  void initState() {
    super.initState();

    Geolocator.requestPermission()
        .then((value) => {
              print(value),
              Geolocator.getCurrentPosition()
                  .then((value) => {
                        print(value),
                        updateLatLong(value.latitude, value.longitude),
                      })
                  .catchError((e) => {print(e)})
            })
        .catchError((e) => {
              print(e),
            });

    SharedPreferences.getInstance().then(
      (prefs) {
        var kk = prefs.getString('MyID');
        var mm = prefs.getString('userImage');
        var nn = prefs.getString('Name');
        idd = kk;
        userName = nn;
        userProfileImg = mm;
      },
    );
  }

  updateLatLong(lat, long) {
    llat = lat;
    lngg = long;

    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
    );
    GetPeopleNearbyMEE();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PEOPLE NEARBY', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Color.fromARGB(255, 238, 232, 232),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    color: Color.fromARGB(255, 238, 232, 232),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (userProfileImg != null)
                                ? imageOfUser()
                                : Image(
                                    image: AssetImage(
                                        'assets/images/user_name.png')),
                            searchBar(),
                            SearchButton()
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            kmBtn(5),
                            kmBtn(15),
                            kmBtn(20),
                            kmBtn(25),
                            kmBtn(50)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      color: Colors.red, height: 600, child: GoogleMappa()),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(255, 238, 232, 232),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.place,
                            color: Colors.orange,
                            size: 20,
                          ),
                          Container(
                            width: 250,
                            child: Text("Place" + " :  " + locationn,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.orange,
                                ),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildBottomDrawer(context),
            (isLoading)
                ? Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black45,
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ));
  }

  var kmDefined = 0;
  var isfollowUser = 0;

  checkKmDefined(int title) {
    switch (title) {
      case 5:
      case 15:
      case 20:
      case 25:
      case 50:
        break;
      default:
    }
  }

  Widget kmBtn(int titile) {
    return Container(
      height: 33,
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.orange,
        width: 2,
      )),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          animationDuration: Duration(seconds: 1),
          textStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onPressed: () => {},
        icon: Icon(
          Icons.search,
          color: Colors.white,
          size: 0,
        ),
        label: Text(
          titile.toString() + " Km",
          style: TextStyle(color: Colors.orange),
        ),
      ),
    );
  }

  Widget imageOfUser() {
    var v = new multimedia();
    print(v.multimediaBaseUrl);

    String fullurl = v.multimediaBaseUrl + userProfileImg;
    print(fullurl);

    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),
      child: new Material(
        shape: new CircleBorder(),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(fullurl),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width - 180,
      height: 30,
      child: TextField(
        controller: _filter,
        onChanged: (value) {
          print(value);
          if (value != "") {
            setState(() {
              isSearch = true;
              searchString = value.toLowerCase();
            });
          } else {
            setState(() {
              isSearch = false;
            });
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: new BorderSide(color: Colors.black38)),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget followingFollowbtn(String titleOfBtn) {
    return Container(
      height: 10,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          animationDuration: Duration(seconds: 1),
          textStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () => {},
        icon: Icon(
          Icons.search,
          color: Colors.white,
          size: 0,
        ),
        label: Text(
          titleOfBtn,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget SearchButton() {
    return Container(
      height: 30,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          // fixedSize: Size(10.0,5.0),
          animationDuration: Duration(seconds: 1),
          textStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () => {},
        icon: Icon(
          Icons.search,
          color: Colors.white,
          size: 18,
        ),
        label: Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget MapContainer() {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Widget _buildBottomDrawer(BuildContext context) {
    // if (callMe) {

    return BottomDrawer(
      duration: Duration(seconds: 1),
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      followTheBody: true,
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.transparent,
      controller: controller_,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          blurRadius: 50,
          spreadRadius: 10,
          offset: const Offset(2, -6), // changes position of shadow
        ),
      ],
    );
    // }
  }

  loadimge(int yy) async {
    var v = multimedia().multimediaBaseUrl;
    imageDataa =
        await NetworkAssetBundle(Uri.parse(v + peopleimage[yy])).load("");
    forListImageByt = imageDataa.buffer.asUint8List();

    print(forListImageByt);
    //Image.memory(forListImageByt);
    return forListImageByt;

// Image.memory(forListImageByt);
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              //top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildButtons(true, 1, 2),
            ),
          ),
          Spacer(),
          Divider(
            height: 0.0,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDrawerBody(BuildContext context) {
    final List<String> entries = <String>[];

    // if(isSearch){
    var tmp = [];
    if (isSearch) {
      for (var i = 0; i < peopleName.length; i++) {
        if (peopleName[i]
            .toString()
            .toLowerCase()
            .contains(searchString.toLowerCase())) tmp.add(i);
      }
    }
    // }
    return Container(
        width: double.infinity,
        height: _bodyHeight,
        color: Colors.transparent,
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: (isSearch) ? tmp.length : totalNearbyCount,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 80,
              color: Colors.white,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 8),
                          Image(
                            image: AssetImage('assets/images/user_name.png'),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (isSearch)
                                ? peopleName[tmp[index]]
                                : peopleName[index],
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 2),
                          Text(
                              (isSearch)
                                  ? distance[tmp[index]]
                                  : distance[index] + " km away",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    SizedBox(width: 2),
                    SizedBox(width: 2),
                    SizedBox(width: 2),
                    ((isSearch)
                            ? isfollowing[tmp[index]] == 0
                            : isfollowing[index] == 0)
                        ? Container(
                            child: ElevatedButton(
                            child: Text("Follow"),
                            onPressed: () {
                              SendFollow(idArray[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ))
                        : Container(
                            child: ElevatedButton(
                            child: Text("Following"),
                            onPressed: () {
                              SendUnFollow(idArray[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          )),
                    SizedBox(width: 0)
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(thickness: 0.0),
        ));
  }

  List<Widget> _buildButtons(bool ff, int start, int end) {
    List<Widget> buttons = [];
    for (int i = start; i <= end; i++)
      buttons.add(TextButton(
        onPressed: () {
          print('triggered');
          setState(() {
            // _button = ff;
            // _bodyHeight = 750.0;
          });
        },
      ));
    return buttons;
  }

  bool _button = true;
  double _headerHeight = 30.0;
  double _bodyHeight = 750.0;
  BottomDrawerController controller_ = BottomDrawerController();
  Widget GoogleMappa() {
    return new Scaffold(
      backgroundColor: Colors.amber,
      body: GoogleMap(
        myLocationEnabled: true,
        markers: markers_,
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<List<int>> makeReceiptImage(pf) async {
    var g = multimedia().multimediaBaseUrl;
    print(g + pf);
    ByteData imageData;
    List<int> bytes;

    try {
      var data = await http.get(Uri.parse(g + pf));
      if (data.statusCode == 200) {
        bytes = data.bodyBytes;
      } else {
        imageData = await rootBundle.load('assets/images/user_name.png');
        bytes = Uint8List.view(imageData.buffer);
      }
    } catch (e) {
      imageData = await rootBundle.load('assets/images/user_name.png');
      bytes = Uint8List.view(imageData.buffer);
    }
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

  var nearbyuserIDList = [];

  Future<dynamic> GetPeopleNearbyMEE() async {
    var t = new MyVector();
    var y = new ApiEndPoints();

    var url = t.baseUrl + y.GetPeoplenearbyme;

    var ff = url +
        apiParameters().LogInUserId +
        "=" +
        idd +
        apiParameters().lat +
        llat.toString() +
        apiParameters().long +
        lngg.toString();

    var response = await http.get(Uri.parse(ff));

    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);
      totalNearbyCount = newBody.length;
      callMe = true;

      filteredNames.clear();
      peopleName.clear();
      isfollowing.clear();
      distance.clear();
      peopleimage.clear();
      idArray.clear();

      for (var i in newBody) {
        var d = i['id'];
        var na = i['name'];
        var pf = i['profilePicture'];
        var lt = i['lat'];
        var lg = i['lng'];
        var loc = i['liveLocation'];
        var dist = i['distence'];
        var isF = i['isFollowing'];

        var tt = (dist as double).toInt();
        idArray.add(d);
        isfollowing.add(isF as int);
        peopleName.add(na.toString());
        distance.add(tt.toString());
        peopleimage.add(pf);

        locationn = loc.toString();
        var img = await makeReceiptImage(pf);

        markers_.add(Marker(
            markerId: MarkerId('Marker' + d.toString()),
            position: LatLng(lt, lg),
            infoWindow: InfoWindow(title: na),
            icon: BitmapDescriptor.fromBytes(img)));
        if (markers_.length > 10) isLoading = false;
        if (REFRESHFLAG == 10) controller_.open();

        setState(() {
          REFRESHFLAG++;
        });
      }

      print(peopleName);
      print(distance);
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something Went Wrong');
      print(response.statusCode);
    }
  }

  Future<dynamic> SendFollow(int toUser) async {
    isLoading = true;
    var url = MyVector().baseUrl + ApiEndPoints().sendFollowing;
    var data = json.encode({
      apiParameters().id: idd.toString(),
      apiParameters().userId: idd.toString(),
      apiParameters().toUserId: toUser.toString(),
    });
    var response = await http.post(Uri.parse(url),
        headers: {header().contentType: header().applicationjson}, body: data);
    if (response.statusCode == 200) {
      GetPeopleNearbyMEE();
    } else {
      print(response.statusCode);
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
    }
  }

  Future<dynamic> SendUnFollow(int toUser) async {
    isLoading = true;
    var url = MyVector().baseUrl + ApiEndPoints().unFollow;
    var data = json.encode({
      apiParameters().id: idd.toString(),
      apiParameters().userId: idd.toString(),
      apiParameters().toUserId: toUser.toString(),
    });
    var response = await http.post(Uri.parse(url),
        headers: {header().contentType: header().applicationjson}, body: data);
    if (response.statusCode == 200) {
      GetPeopleNearbyMEE();
    } else {
      print(response.statusCode);
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
    }
  }
}
