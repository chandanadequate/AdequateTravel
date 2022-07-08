//VideosGallery
import 'dart:convert';
import 'package:adequate_travel_app/video_items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/images_video_model.dart';
import 'Networking/ApiURLs.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(VideosGallery());

class VideosGallery extends StatefulWidget {
  String id;
  VideosGallery({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _VideosGalleryPageState createState() => _VideosGalleryPageState();
}

class _VideosGalleryPageState extends State<VideosGallery> {
  bool flag = false;
  var videoJsonBody = ImagesModel();
  String idd = "0";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (prefs) {
        idd = prefs.getString('MyID');
        GetVideoList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIDEO GALLERY', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: (flag == true)
          ? ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: videoJsonBody.media.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Stack(children: [
                    YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId:
                            videoJsonBody.media[index].url.split("?v=")[1],
                        flags: YoutubePlayerFlags(
                          autoPlay: false,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                    ),
                    Positioned(
                        bottom: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 5),
                                  Icon(Icons.thumb_up_alt_rounded,
                                      color: Colors.orange, size: 16),
                                  SizedBox(width: 2),
                                  Text(
                                      videoJsonBody.media[index].likeCount
                                          .toString(),
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
                                  Text(
                                      videoJsonBody.media[index].commentCount
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white)),
                                  SizedBox(width: 2),
                                  Text('Comments',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white)),
                                  SizedBox(width: 20)
                                ],
                              ),
                            ],
                          ),
                        ))
                  ]),
                );
              })
          : Text("No videos has been uploaded"),
    );
  }

  Future<dynamic> GetVideoList() async {
    var Url = MyVector().baseUrl + ApiEndPoints().GetImagesAndVideos;

    var response = await http.get(
        Uri.parse(Url +
            apiParameters().UserId +
            "=" +
            idd +
            "&" +
            apiParameters().Mediatype +
            MediaType().video.toString()),
        headers: {header().contentType: header().applicationjson});

    if (response.statusCode == 200) {
      var newBody = json.decode(response.body);
      videoJsonBody = ImagesModel.fromJson(newBody);
      setState(() {
        flag = true;
      });
    } else {
      print(response.statusCode);
    }
  }
}
