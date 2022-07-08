class MyVector {
  String baseUrl = "https://api.adequatetravel.com/v2/api/";
}

class multimedia {
  String multimediaBaseUrl = "https://adequatetravel.com/ATMultimedia/";
}

class apiParameters {
  String id = "id";
  String Username = "Username";
  String email = "email";
  String password = "password";
  String Password = "Password";
  String loginDevice = "loginDevice";
  String newpassword = "newpassword";
  String currentPassword = "currentPassword";
  String code = "code";
  String userId = "UserId";
  String toUserId = "ToUserId";
  String msg = "msg";
  String name = "name";
  String UserId = "UserId";
  String LogInUserId = "LogInUserId";
  String gender = "gender";
  String Mediatype = "&Mediatype=";
  String query = "query";
  String phone = "phone";
  String lat = "&lat=";
  String long = "&lng=";
}

class ApiEndPoints {
  String Login = "Account/login";
  String Register = "Account/Register";
  String VerifyAccount = "Account/VerifyAccount";
  String ResendOtp = "Account/ResendOtp";
  String GetNewPassword = "Account/GetNewPassword";
  String GetUserDashboard = "Users/GetUserDashboard?";
  String GetUserProfile = "Users/GetUserProfile?";
  String GetPeoplenearbyme = "Users/GetPeoplenearbyme?";
  String GetImagesAndVideos = "MultiMedias/GetImageandVideo?";
  String ResetPassword = "Account/ResetPassword";
  String PostContactus = "Account/PostContactus";
  String sendFollowing = "UserFollowers/PostUserFollower";
  String unFollow = "UserFriends/ResponseFriend";
  String getFollowersAndFollowing = "UserFollowers/GetFollowersandFollowing?";
}

class header {
  String contentType = "Content-Type";
  String applicationjson = "application/json";
}

class MediaType {
  int images = 1;
  int video = 2;
}
