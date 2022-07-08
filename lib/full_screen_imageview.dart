import 'package:adequate_travel_app/Networking/ApiURLs.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String dp;
  final String name;
  final String place;
  final String title;
  final String likes;
  final String CommnetsC;

  const FullScreenImage(
      {Key key,
      this.imageUrl,
      this.tag,
      this.dp,
      this.name,
      this.place,
      this.title,
      this.likes,
      this.CommnetsC})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        color: Colors.orange,
                        size: 18,
                      ),
                      Container(
                        width: 250,
                        child: Text(place,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.orange,
                            ),
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: (() => {Navigator.pop(context)}),
                child: Icon(Icons.close_outlined, size: 30),
              ),
            ],
          ),
          leading: new Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),
            child: new Material(
              shape: new CircleBorder(),
              child: CircleAvatar(
                radius: 10,
                backgroundImage:
                    NetworkImage(multimedia().multimediaBaseUrl + dp),
              ),
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: PhotoView(
                  imageProvider:
                      NetworkImage(multimedia().multimediaBaseUrl + imageUrl),
                ),
              ),
              Row(children: [
                SizedBox(width: 8),
                Text(title,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.left),
              ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.thumb_up_outlined,
                          color: Colors.orange, size: 25),
                      SizedBox(width: 2),
                      Text(likes,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      TextButton(
                        //  onPressed: () => ,
                        child: Text('Like',
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.insert_comment_outlined,
                          color: Colors.orange, size: 25),
                      SizedBox(width: 2),
                      Text(
                        CommnetsC,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      TextButton(
                        //  onPressed: () => ,
                        child: Text('Comments',
                            textAlign: TextAlign.right,
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ));
  }
}
