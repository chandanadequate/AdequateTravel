// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:convert';
import 'package:adequate_travel_app/Models/dashboard_model.dart';
import 'package:adequate_travel_app/Models/images_video_model.dart';
import 'package:adequate_travel_app/Models/profile_model.dart';
import 'package:adequate_travel_app/Utils/alert.dart';
import 'package:adequate_travel_app/following_screen.dart';
import 'package:adequate_travel_app/image_gallery.dart';
import 'package:adequate_travel_app/people_nearby_screen.dart';
import 'package:adequate_travel_app/videos_gallery.dart';
import 'package:share/share.dart';
import 'package:adequate_travel_app/help_and_support_screen.dart';
import 'package:adequate_travel_app/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'Networking/ApiURLs.dart';
import 'account_settings.dart';
import 'followers_list.dart';

void main() => runApp(MenuScreen());

class MenuScreen extends StatefulWidget {
  final int id;
  final String imageUrl;
  final String NameUser;

  MenuScreen({Key key, this.id, this.imageUrl, this.NameUser, this.title})
      : super(key: key);

  final String title;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<int> selectedIndexList = new List<int>();
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  int Id;
  String ImageUrl;
  String nameUser;
  var bodyJson = userDashboadDetail();
  var profileJson = ProfileData();
  int peopleNearCount = 0;
  var imageCount = ImagesModel();
  var videoCount = VideosModel();
  int selectedIndex = 0;
  int _selectedIndex = 0;
  String totalVideos = "0";
  String totalImage = "0";
  var isLoading = true;
  double llat = 0.0;
  double lngg = 0.0;

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
  }

  updateLatLong(lat, long) {
    llat = lat;
    lngg = long;

    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
    );

    GetUserDashBoardDetails();

    GetImage();
    GetVideos();
  }

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
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xfff79c4f)))
          ],
        ),
      ),
    );
  }

  Widget dp() {
    return SafeArea(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 48, // Image radius
            backgroundImage:
                NetworkImage(multimedia().multimediaBaseUrl + widget.imageUrl),
            foregroundColor: Color.fromARGB(240, 255, 153, 0),
          ),
        ],
      ),
    );
  }

  Widget MenuView() {
    return TabBarView(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 238, 232, 232),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              _userImage(),
              _divider(),
              _shareImage(),
              _divider(),
              SizedBox(height: 10),
              _grid(),
              SizedBox(height: 10),
              _divider(),
              _helpNSupport(),
              SizedBox(height: 0),
              _divider(),
              _accountSetting(),
              SizedBox(height: 0),
              _divider(),
              _logout(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('MENU', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: TabBarView(
          children: [MenuView()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/home.png"),
                //color: Color(0xFF3A5A98),
              ),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/home.png"),
                //color: Color(0xFF3A5A98),
              ),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: onItemTappedNew,
        ),
      ),
    );
  }

  void onItemTappedNew(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget menuView() {
    return Wrap(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 238, 232, 232),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                _userImage(),
                _divider(),
                _shareImage(),
                _divider(),
                SizedBox(height: 10),
                _grid(),
                SizedBox(height: 10),
                _divider(),
                _helpNSupport(),
                SizedBox(height: 5),
                _divider(),
                _accountSetting(),
                SizedBox(height: 5),
                _divider(),
                _logout(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _grid() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: <Widget>[
        SizedBox(
          height: 100,
          width: 170,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.white,
            onPressed: () {},
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/images/menu_trip.png'),
                  onPressed: () {},
                ),
                Text(bodyJson.trips.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal)),
                Text('TRIP'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: 170,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: () {},
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/images/menu_my_rewards.png'),
                  onPressed: () {},
                ),
                Text(bodyJson.myRewords.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal)),
                Text('MY REWARDS'),
              ],
            ),
          ),
        ),
        SizedBox(
          //menu_followers
          //3
          height: 100,
          width: 170,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => FollowersListScreen()));
            },
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/images/menu_followers.png'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => FollowersListScreen()));
                  }, //FollowersListScreen
                ),
                Text(profileJson.followerCount.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal)),
                Text('FOLLOWERS'),
              ],
            ),
          ),
        ),
        SizedBox(
          //4
          height: 100,
          width: 170,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => FollowingScreen()));
            },
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/images/menu_following.png'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => FollowingScreen()));
                  },
                ),
                Text(profileJson.followingCount.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal)),
                Text('FOLLOWING'),
              ],
            ),
          ),
        ),
        SizedBox(
          //5
          height: 100,
          width: 170,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),

              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => ImageGallery()));
            },
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/images/menu_image.png'),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ImageGallery()));
                  },
                ),
                Text(totalImage,
                    style: TextStyle(fontWeight: FontWeight.normal)),
                Text('IMAGES'),
              ],
            ),
          ),
        ),
        SizedBox(
          //6
          height: 100,
          width: 170,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),

              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => VideosGallery()));
            },
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/images/menu_videos.png'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => VideosGallery()));
                  },
                ),
                Text(totalVideos,
                    style: TextStyle(fontWeight: FontWeight.normal)),
                Text('VIDEOS'),
              ],
            ),
          ),
        ),
        SizedBox(
          //7
          height: 100,
          width: 170,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),

              //side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => PeopleNearBy()));
            },
            child: Column(
              children: [
                IconButton(
                  icon: Image.asset('assets/images/menu_near_by_me.png'),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => PeopleNearBy(
                                  id: widget.id.toString(),
                                )));
                  },
                ),
                Text(peopleNearCount.toString(),
                    style: TextStyle(fontWeight: FontWeight.normal)),
                Text('PEOPLE NEARBY'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _userImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            height: 60,
            width: 60,
            child: (widget.imageUrl != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                        multimedia().multimediaBaseUrl + widget.imageUrl),
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_name'),
                  )),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.NameUser != null)
                ? Text(widget.NameUser,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left)
                : Text('Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
            Row(
              children: [
                // Icon(
                //   Icons.place,
                //   color: Colors.orange,
                //   size: 18,
                // ),
                Container(
                  width: 250,
                  child: Text('See your profile',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            )
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     (widget.NameUser != null)
        //         ? Text(widget.NameUser,
        //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //             textAlign: TextAlign.left)
        //         : Text('Name',
        //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //             textAlign: TextAlign.left),
        //     SizedBox(width: 10),
        //     Text(
        //       'See your profile',
        //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _shareImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image(
          height: 50,
          image: AssetImage('assets/images/menu_share.png'),
          alignment: Alignment.topCenter,
        ),
        SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              child: Text('Share with Friends'),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
              ),
              onPressed: () {
                _onShareData(context);
              },
            )
          ],
        ),
      ],
    );
  }

  _onShareData(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    {
      await Share.share(
          'Wanna gain your Vacation Calories! Download Adequate Travel App and Connect To Travelers Worldwide and share your travel stories.',
          subject: "Adequate Travel",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Widget _helpNSupport() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image(
          height: 30,
          image: AssetImage('assets/images/help.png'),
          color: Color.fromARGB(240, 255, 153, 0),
          alignment: Alignment.topCenter,
        ),
        SizedBox(width: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              child: Text('Help & Support'),
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => HelpPage()),
                );
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _accountSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image(
          height: 30,
          image: AssetImage('assets/images/setting.png'),
          color: Color.fromARGB(240, 255, 153, 0),
          alignment: Alignment.topCenter,
        ),
        SizedBox(width: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              child: Text('Account settings'),
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => accountSetting()),
                );
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _logout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image(
          height: 30,
          image: AssetImage('assets/images/logout.png'),
          alignment: Alignment.topCenter,
        ),
        SizedBox(width: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              child: Text('Logout'),
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
              ),
              onPressed: () async {
                var value = await SharedPreferences.getInstance();
                value.clear();

                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => Login()),
                );
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 0,
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
        ],
      ),
    );
  }

  Future<dynamic> GetUserDashBoardDetails() async {
    var url = MyVector().baseUrl + ApiEndPoints().GetUserDashboard;

    var response = await http.get(
        Uri.parse(url + apiParameters().UserId + "=" + widget.id.toString()),
        headers: {header().contentType: header().applicationjson});

    if (response.statusCode == 200) {
      setState(() {
        var newBody = json.decode(response.body);
        bodyJson = userDashboadDetail.fromJson(newBody);
        GetPeopleNearbyME();
      });
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
      print(response.statusCode);
    }
  }

  Future<dynamic> ProfileDetails() async {
    var url = MyVector().baseUrl + ApiEndPoints().GetUserProfile;
    isLoading = true;

    var response = await http.get(
        Uri.parse(url + apiParameters().UserId + "=" + widget.id.toString()),
        headers: {header().contentType: header().applicationjson});

    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);

      profileJson = ProfileData.fromJson(newBody);

      isLoading = false;
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
      print(response.statusCode);
    }
  }

  Future<dynamic> GetPeopleNearbyME() async {
    var url = MyVector().baseUrl + ApiEndPoints().GetPeoplenearbyme;
    isLoading = true;

    var response = await http.get(
        Uri.parse(url +
            apiParameters().LogInUserId +
            "=" +
            widget.id.toString() +
            apiParameters().lat +
            llat.toString() +
            apiParameters().long +
            lngg.toString()),
        headers: {header().contentType: header().applicationjson});

    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);

      setState(() {
        peopleNearCount = newBody.length;
      });
      isLoading = false;
      ProfileDetails();
      //});
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
      print(response.statusCode);
    }
  }

  Future<dynamic> GetImage() async {
    var url = MyVector().baseUrl + ApiEndPoints().GetImagesAndVideos;

    var response = await http.get(
        Uri.parse(url +
            apiParameters().UserId +
            "=" +
            widget.id.toString() +
            "&" +
            apiParameters().Mediatype +
            MediaType().images.toString()),
        headers: {header().contentType: header().applicationjson});

    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);

      imageCount = ImagesModel.fromJson(newBody);
      setState(() {
        totalImage = imageCount.media.length.toString();
      });
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
      print(response.statusCode);
    }
  }

  Future<dynamic> GetVideos() async {
    var url = MyVector().baseUrl + ApiEndPoints().GetImagesAndVideos;

    var response = await http.get(
        Uri.parse(url +
            apiParameters().UserId +
            "=" +
            widget.id.toString() +
            "&" +
            apiParameters().Mediatype +
            MediaType().video.toString()),
        headers: {header().contentType: header().applicationjson});

    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);

      setState(() {
        videoCount = VideosModel.fromJson(newBody);
        totalVideos = videoCount.media.length.toString();
      });
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
      print(response.statusCode);
    }
  }
}
