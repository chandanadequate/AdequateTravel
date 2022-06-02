import 'dart:ffi';
import 'package:flutter/material.dart';


class MyVector {
  String baseUrl = "https://api.adequatetravel.com/v2/api/Account/";

}

class apiParameters{
  String Username = "Username";
  String email = "email";
  String password = "password";
  String Password = "Password";
  String loginDevice = "loginDevice";
  String name = "name";


}

class ApiEndPoints{
  String Login = "login";
  String Register = "Register";
  String VerifyAccount = "VerifyAccount";
  String ResendOtp = "ResendOtp";
  String GetNewPassword = "GetNewPassword";

}

class header{
 String contentType = "Content-Type";
 String applicationjson = "application/json";
}



class ApiKeys{


}


