import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/following_model.dart';
import 'Networking/ApiURLs.dart';
import 'Utils/alert.dart';

void main() => runApp(FollowersListScreen());

class FollowersListScreen extends StatefulWidget {
  String id;

  FollowersListScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FollowersScreenPageState createState() => _FollowersScreenPageState();
}

class _FollowersScreenPageState extends State<FollowersListScreen> {
  var obj = new following_model();
  List objList = <Widget>[];
  List objList1 = [];
  String idd = "0";
  String userName = "";
  String userProfileImg = "";

  var searchString = "";
  bool isSearch = false;
  bool flag = false;
  Map<String, dynamic> j;

  get fontSize => null;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then(
      (prefs) {
        var kk = prefs.getString('MyID');
        var mm = prefs.getString('userImage');
        var nn = prefs.getString('Name');
        idd = kk;
        userName = nn;
        userProfileImg = mm;
        getFollowingList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              searchBoxContainer(),
              Container(
                height: MediaQuery.of(context).size.height - 175,
                child: SingleChildScrollView(
                    child: Column(
                  children: (objList1 != null)
                      ? objList1.map((e) {
                          return (e['userRelation'] == 2)
                              ? Column(
                                  children: [
                                    _divider(),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 222, 215, 215),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 4,
                                            offset:
                                                Offset(4, 8), // Shadow position
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.all(10),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Image(
                                                height: 200,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                                image: NetworkImage(multimedia()
                                                        .multimediaBaseUrl +
                                                    e['user']['coverPicture']),
                                              ),
                                              SizedBox(height: 50),
                                              Text(e['user']['name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16)),
                                              Text("followed by " +
                                                  e['user']['followedBy']
                                                      .toString() +
                                                  " person"),
                                              SizedBox(height: 10),
                                              (e['isFollowing'] == true)
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shadowColor:
                                                            Colors.grey,
                                                        primary: Colors
                                                            .blue, // background (button) color
                                                        onPrimary: Colors
                                                            .white, // foreground (text) color
                                                      ),
                                                      onPressed: () =>
                                                          SendUnFollow(e['user']
                                                              ['userId']),
                                                      child: const Text(
                                                          'UNFOLLOW'),
                                                    )
                                                  : ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .orange, // background (button) color
                                                        onPrimary: Colors
                                                            .white, // foreground (text) color
                                                      ),
                                                      onPressed: () =>
                                                          print('FOLLOW'),
                                                      child:
                                                          const Text('FOLLOW'),
                                                    ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          Positioned(
                                            left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                60,
                                            top: 150,
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              // width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(multimedia()
                                                          .multimediaBaseUrl +
                                                      e['user']
                                                          ['profilePicture']),
                                                ),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Text('');
                        }).toList()
                      : Text('You have no followers'),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBoxContainer() {
    return Container(
      margin: EdgeInsetsDirectional.all(10),
      color: Color.fromARGB(255, 238, 232, 232),
      width: MediaQuery.of(context).size.width - 11,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
            border: Border.all(
              color: Colors.transparent,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (userProfileImg != null)
                  ? imageOfUser()
                  : Image(image: AssetImage('assets/images/user_name.png')),
              searchBar(),
              SearchButton(),
            ],
          ),
        )
      ]),
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

  Widget SearchButton() {
    return Container(
      height: 30,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          shadowColor: Colors.grey,
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
      height: 40,
      child: TextField(
        //controller: _filter,
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

  Future<dynamic> getFollowingList() async {
    objList1 = [];

    var url = MyVector().baseUrl + ApiEndPoints().getFollowersAndFollowing;
    print(url + apiParameters().UserId + "=" + idd);

    var response = await http.get(
        Uri.parse(url + apiParameters().UserId + "=" + idd),
        headers: {header().contentType: header().applicationjson});
    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);

      setState(() {
        objList1 = newBody;
        flag = true;
      });
    } else {
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
      print(response.statusCode);
    }
  }

  Future<dynamic> SendUnFollow(int toUser) async {
    // isLoading = true;
    var url = MyVector().baseUrl + ApiEndPoints().unFollow;
    var data = json.encode({
      apiParameters().id: idd.toString(),
      apiParameters().userId: idd.toString(),
      apiParameters().toUserId: toUser.toString(),
    });
    var response = await http.post(Uri.parse(url),
        headers: {header().contentType: header().applicationjson}, body: data);
    if (response.statusCode == 200) {
      print('successfully unfollowed');
      getFollowingList();
    } else {
      print(response.statusCode);
      Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');
    }
  }
}


//import 'dart:convert';
//import 'package:adequate_travel_app/Networking/ApiURLs.dart';

//import 'package:http/http.dart' as http;
//import 'Utils/alert.dart';

// void main() => runApp(FollowersListScreen());

// class FollowersListScreen extends StatefulWidget {
//   FollowersListScreen({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _FollowersListScreenPageState createState() =>
//       _FollowersListScreenPageState();
// }

// class _FollowersListScreenPageState extends State<FollowersListScreen> {
//   TextEditingController message = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('FAQ', style: TextStyle(color: Colors.black)),
//           backgroundColor: Colors.orange,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         resizeToAvoidBottomInset: false,
//         body: Container(
//           height: height,
//           child: Stack(
//             children: <Widget>[
//               Image(
//                 image: AssetImage('assets/images/splashPlain.png'),
//                 alignment: Alignment.center,
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 fit: BoxFit.fill,
//               ),
//               Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     //child: SingleChildScrollView(
//                     child: Container(
//                       margin: EdgeInsets.only(top: 40),
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: <Widget>[],
//                       ),
//                     ),
//                     // ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }
// //Alerti.showAlertDialog(context, 'Alert', 'Something went wrong');