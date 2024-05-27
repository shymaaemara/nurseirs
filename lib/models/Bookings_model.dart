import 'package:flutter/cupertino.dart';


class Bookings {
  Bookings({
    String? id,
    String? histairy,
    String? namehospitail,
    String ?name,
    String? phone,

    String? age,


    String? uid,
    String? extra,

  }) {
    _id = id;
    _histairy= histairy;
    _name =  name;
    _phone =  phone;
    _age =  age;
    _uid = uid;
    _extra = extra;
    _namehospitail = namehospitail;
  }

  Bookings.fromJson(dynamic json) {
    _id = json['id'];
    _extra = json['extra'];
    _name = json['name'];
    _phone = json['phone'];
    _histairy = json['histairy'];
    _age= json['age'];
    _namehospitail = json['namehospitail'];
    _uid = json['uid'];
  }

  String? _id;
  String?  _name ;
  String? _phone;
  String? _age;
  String?  _histairy;
  String? _extra;

  String? _namehospitail;
  String? _uid;


  String? get id => _id;
  String? get extra =>_extra;
  String? get histairy=> _histairy;
  String? get name=>_name;
  String? get phone=> _phone;
  String? get  age => _age;
  String? get uid => _uid;
  String? get namehospitail => _namehospitail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['histairy'] = _histairy;
    map['name'] = name;
    map['phone'] = phone;
    map['age'] = _age;
    map['extra'] = _extra;
    map['namehospitail'] = _namehospitail;
    map['uid'] = _uid;
    return map;
  }
}
