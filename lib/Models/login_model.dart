import 'package:flutter/material.dart';
import 'dart:convert';


class login_Model {
  int id;
  String email;
  String name;
  String profilePicture;
  String coverPic;
  String token;
  Null city;
  String country;
  int countryId;
  int gender;
  bool enablefollowme;
  bool sendmenotifications;
  bool sendTextmessages;
  bool enabletagging;
  Null dob;
  Null about;
  int creditBalance;
  int code;
  Null msg;
  Null data;

  login_Model(
      {this.id,
        this.email,
        this.name,
        this.profilePicture,
        this.coverPic,
        this.token,
        this.city,
        this.country,
        this.countryId,
        this.gender,
        this.enablefollowme,
        this.sendmenotifications,
        this.sendTextmessages,
        this.enabletagging,
        this.dob,
        this.about,
        this.creditBalance,
        this.code,
        this.msg,
        this.data});

  login_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    coverPic = json['coverPic'];
    token = json['token'];
    city = json['city'];
    country = json['country'];
    countryId = json['countryId'];
    gender = json['gender'];
    enablefollowme = json['enablefollowme'];
    sendmenotifications = json['sendmenotifications'];
    sendTextmessages = json['sendTextmessages'];
    enabletagging = json['enabletagging'];
    dob = json['dob'];
    about = json['about'];
    //creditBalance = json['creditBalance'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['coverPic'] = this.coverPic;
    data['token'] = this.token;
    data['city'] = this.city;
    data['country'] = this.country;
    data['countryId'] = this.countryId;
    data['gender'] = this.gender;
    data['enablefollowme'] = this.enablefollowme;
    data['sendmenotifications'] = this.sendmenotifications;
    data['sendTextmessages'] = this.sendTextmessages;
    data['enabletagging'] = this.enabletagging;
    data['dob'] = this.dob;
    data['about'] = this.about;
    data['creditBalance'] = this.creditBalance;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}




