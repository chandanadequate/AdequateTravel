class ProfileData {
  int id;
  String name;
  String gender;
  String profilePicture;
  String coverPicture;
  int friendType;
  int userRelation;
  double distence;
  Null liveLocation;
  double lat;
  double lng;
  int isFollowing;
  int followerCount = 0;
  int followingCount = 0;
  int friendsCount;
  String aboutme;
  int userTripsCount;
  Null address;
  double age;
  Null contactNo;
  Null dob;
  String city;

  ProfileData(
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
      this.city});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
