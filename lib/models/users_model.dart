import 'package:firebase_database/firebase_database.dart';

class Users {
  Users({
    this.name,
    this.password,
    this.phoneNumber,
    this.uid,
    this.address,
    this.email,});

  Users.fromJson(dynamic json) {
    name = json['name'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    uid = json['uid'];
    address = json['address'];
    email = json['email'];
  }

  String? phoneNumber;
  String? fullName;
  String ?name;
  String ?password;

  String ?uid;
  String ?address;
  String ?email;
  String? dt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['password'] = password;
    map['phoneNumber'] = phoneNumber;
    map['uid'] = uid;
    map['address'] = address;
    map['email'] = email;
    return map;
  }


  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot
        .child("uid")
        .value
        .toString());
    email = (dataSnapshot
        .child("email")
        .value
        .toString());
    fullName = (dataSnapshot
        .child("name")
        .value
        .toString());
    phoneNumber = (dataSnapshot
        .child("phoneNumber")
        .value
        .toString());
    dt = (dataSnapshot
        .child("dt")
        .value
        .toString());
    password = (dataSnapshot
        .child("password")
        .value
        .toString());
    address = (dataSnapshot
        .child("address")
        .value
        .toString());
  }


}


















