class following_model {
  int id = 0;
  User user;
  int friendSince = 0;
  int mutualFriend = 0;
  //Null mutualFriends;
  bool isFollowing = false;
  int userRelation = 0;
  int requestStatus = 0;
  int imageCount = 0;
  int videoCount = 0;
  int friendCount = 0;

  following_model(
      {this.id,
      this.user,
      this.friendSince,
      this.mutualFriend,
      //this.mutualFriends,
      this.isFollowing,
      this.userRelation,
      this.requestStatus,
      this.imageCount,
      this.videoCount,
      this.friendCount});

  following_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    friendSince = json['friendSince'];
    mutualFriend = json['mutualFriend'];
    // mutualFriends = json['mutualFriends'];
    isFollowing = json['isFollowing'];
    userRelation = json['userRelation'];
    requestStatus = json['requestStatus'];
    imageCount = json['imageCount'];
    videoCount = json['videoCount'];
    friendCount = json['friendCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['friendSince'] = this.friendSince;
    data['mutualFriend'] = this.mutualFriend;
    // data['mutualFriends'] = this.mutualFriends;
    data['isFollowing'] = this.isFollowing;
    data['userRelation'] = this.userRelation;
    data['requestStatus'] = this.requestStatus;
    data['imageCount'] = this.imageCount;
    data['videoCount'] = this.videoCount;
    data['friendCount'] = this.friendCount;
    return data;
  }
}

class User {
  int userId = 0;
  int followedBy = 0;
  String name = "";
  String profilePicture = "";
  String coverPicture = "";
  // Null userCountry;

  User({
    this.userId,
    this.followedBy,
    this.name,
    this.profilePicture,
    this.coverPicture,
    //this.userCountry
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    followedBy = json['followedBy'];
    name = json['name'];
    profilePicture = json['profilePicture'];

    print(profilePicture);

    coverPicture = json['coverPicture'];
    //userCountry = json['userCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['followedBy'] = this.followedBy;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['coverPicture'] = this.coverPicture;
    // data['userCountry'] = this.userCountry;
    return data;
  }
}
