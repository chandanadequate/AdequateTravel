

class userDashboadDetail {
  double myCash;
  double myRewords;
  int myBookings;
  int package;
  int trips;
  int post;
  int article;

  userDashboadDetail(
      {this.myCash,
      this.myRewords,
      this.myBookings,
      this.package,
      this.trips,
      this.post,
      this.article});

  userDashboadDetail.fromJson(Map<String, dynamic> json) {
    myCash = json['myCash'];
    myRewords = json['myRewords'];
    myBookings = json['myBookings'];
    package = json['package'];
    trips = json['trips'];
    post = json['post'];
    article = json['article'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myCash'] = this.myCash;
    data['myRewords'] = this.myRewords;
    data['myBookings'] = this.myBookings;
    data['package'] = this.package;
    data['trips'] = this.trips;
    data['post'] = this.post;
    data['article'] = this.article;
    return data;
  }
}