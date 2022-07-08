import 'dart:convert';
import 'package:adequate_travel_app/Networking/ApiURLs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/images_video_model.dart';
import 'full_screen_imageview.dart';

void main() => runApp(ImageGallery());

class ImageGallery extends StatefulWidget {
  String id;

  ImageGallery({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImageGalleryPageState createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGallery> {
  var imageGalleryJson = ImagesModel();
  bool flag = false;

  List ImageArray;
  String id;
  String mm;
  String userProfileImg;
  String userName;

  var obj = ImagesModel();

  get items => null;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then(
      (prefs) {
        var kk = prefs.getString('MyID');
        var mm = prefs.getString('userImage');
        var nn = prefs.getString('Name');
        id = kk;
        userName = nn;
        userProfileImg = mm;
        Images();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMAGE GALLERY', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: (flag == true)
          ? GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: obj.media.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenImage(
                        imageUrl: obj.media[index].url,
                        tag: obj.media[index].url,
                        place: obj.media[index].place,
                        name: userName,
                        dp: userProfileImg,
                        title: obj.media[index].title,
                        CommnetsC: obj.media[index].commentCount.toString(),
                        likes: obj.media[index].likeCount.toString(),
                      );
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(multimedia().multimediaBaseUrl +
                              obj.media[index].url),
                          fit: BoxFit.cover),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.thumb_up_alt_rounded,
                                  color: Colors.orange, size: 16),
                              SizedBox(width: 2),
                              Text(obj.media[index].likeCount.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)),
                              SizedBox(width: 2),
                              Text('Like',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.comment,
                                  color: Colors.orange, size: 16),
                              SizedBox(width: 2),
                              Text(obj.media[index].commentCount.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)),
                              SizedBox(width: 2),
                              Text('Comments',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Text("Data not found"),

      // ),
    );
  }

  Future<dynamic> Images() async {
    var url = MyVector().baseUrl + ApiEndPoints().GetImagesAndVideos;

    var response = await http.get(
        Uri.parse(url +
            apiParameters().UserId +
            "=" +
            id +
            "&" +
            apiParameters().Mediatype +
            MediaType().images.toString()),
        headers: {header().contentType: header().applicationjson});

    print(response);

    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);
      obj = ImagesModel.fromJson(newBody);
      // var bodyy = newBody['media'];

      // for (var i in bodyy) {
      //   var kk = i['url'];
      //   var cc = i['commentCount'];
      //   var ll = i['likeCount'];
      //   var pp = i['place'];
      //   var ti = i['title'];

      //   var tt = multimedia().multimediaBaseUrl + kk;
      //   Array.add(tt);
      //   CommentCountArray.add(cc);
      //   LikeCountArray.add(ll);
      //   PlaceName.add(pp);
      //   ImageTitle.add(ti);
      // }

      setState(() {
        flag = true;
      });
    } else {
      print(response.statusCode);
    }
  }
}
