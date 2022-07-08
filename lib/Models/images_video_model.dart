class ImagesModel {
  int totalRecord;
  List<Media> media;

  ImagesModel({this.totalRecord, this.media});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    totalRecord = json['totalRecord'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRecord'] = this.totalRecord;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int id;
  String title;
  String name;
  String description;
  String url;
  int mediatype;
  int likeCount;
  int commentCount;
  String place;
  String createAt;

  Media(
      {this.id,
      this.title,
      this.name,
      this.description,
      this.url,
      this.mediatype,
      this.likeCount,
      this.commentCount,
      this.place,
      this.createAt});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    print(id);
    title = json['title'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    print(url);
    mediatype = json['mediatype'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    place = json['place'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['description'] = this.description;
    data['url'] = this.url;
    data['mediatype'] = this.mediatype;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    data['place'] = this.place;
    data['createAt'] = this.createAt;
    return data;
  }
}

class VideosModel {
  int totalRecord;
  List<Media> media;

  VideosModel({this.totalRecord, this.media});

  VideosModel.fromJson(Map<String, dynamic> json) {
    totalRecord = json['totalRecord'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalRecord'] = this.totalRecord;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
