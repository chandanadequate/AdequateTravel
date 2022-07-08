class PeopleNearbyModel {
  int id;
  String name;
  String gender;
  String profilePicture;
  String coverPicture;
  int friendType;
  int userRelation;
  int distence;
  String liveLocation;
  int lat;
  int lng;
  int isFollowing;
  int followerCount;
  int followingCount;
  int friendsCount;
  String aboutme;
  int userTripsCount;
  String address;
  int age;
  String contactNo;
  String dob;
  String city;
  List<ImagesList> imagesList;
  List<VideosList> videosList;

  PeopleNearbyModel(
      {this.id,
      this.name,
      this.gender,
      this.profilePicture,
      this.coverPicture,
      this.friendType,
      this.userRelation,
      this.distence,
      this.liveLocation,
      this.lat,
      this.lng,
      this.isFollowing,
      this.followerCount,
      this.followingCount,
      this.friendsCount,
      this.aboutme,
      this.userTripsCount,
      this.address,
      this.age,
      this.contactNo,
      this.dob,
      this.city,
      this.imagesList,
      this.videosList});

  PeopleNearbyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    profilePicture = json['profilePicture'];
    coverPicture = json['coverPicture'];
    friendType = json['friendType'];
    userRelation = json['userRelation'];
    distence = json['distence'];
    liveLocation = json['liveLocation'];
    lat = json['lat'];
    lng = json['lng'];
    isFollowing = json['isFollowing'];
    followerCount = json['followerCount'];
    followingCount = json['followingCount'];
    friendsCount = json['friendsCount'];
    aboutme = json['aboutme'];
    userTripsCount = json['userTripsCount'];
    address = json['address'];
    age = json['age'];
    contactNo = json['contactNo'];
    dob = json['dob'];
    city = json['city'];
    if (json['imagesList'] != null) {
      imagesList = <ImagesList>[];
      json['imagesList'].forEach((v) {
        imagesList.add(new ImagesList.fromJson(v));
      });
    }
    if (json['videosList'] != null) {
      videosList = <VideosList>[];
      json['videosList'].forEach((v) {
        videosList.add(new VideosList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['profilePicture'] = this.profilePicture;
    data['coverPicture'] = this.coverPicture;
    data['friendType'] = this.friendType;
    data['userRelation'] = this.userRelation;
    data['distence'] = this.distence;
    data['liveLocation'] = this.liveLocation;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['isFollowing'] = this.isFollowing;
    data['followerCount'] = this.followerCount;
    data['followingCount'] = this.followingCount;
    data['friendsCount'] = this.friendsCount;
    data['aboutme'] = this.aboutme;
    data['userTripsCount'] = this.userTripsCount;
    data['address'] = this.address;
    data['age'] = this.age;
    data['contactNo'] = this.contactNo;
    data['dob'] = this.dob;
    data['city'] = this.city;
    if (this.imagesList != null) {
      data['imagesList'] = this.imagesList.map((v) => v.toJson()).toList();
    }
    if (this.videosList != null) {
      data['videosList'] = this.videosList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImagesList {
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

  ImagesList(
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

  ImagesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
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

class VideosList {
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

  VideosList(
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

  VideosList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
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
