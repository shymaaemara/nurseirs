import 'package:flutter/cupertino.dart';


class Booking {
  Booking({
    String? id,
    String? histairy,
    String ?name,
    String? phone,
    String? namehospitail,
    String? age,


    String? uid,
    String? extra,

  }) {
    _id = id;
    _histairy= histairy;
    _age =  age;
    _name =  name;
    _phone =  phone;
    _uid = uid;
    _extra = extra;
    _namehospitail = namehospitail;
  }

  Booking.fromJson(dynamic json) {
    _id = json['id'];
    _extra = json['extra'];
    _name = json['name'];
    _histairy = json['histairy'];
    _phone = json['phone'];
    _age= json['age'];
    _namehospitail = json['namehospitail'];
    _uid = json['uid'];
  }

  String? _id;
  String? _age;
  String?  _histairy;
  String? _extra;
  String?  _name ;
  String? _phone;

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
    map['name'] = name;
    map['phone'] = phone;
    map['histairy'] = _histairy;
    map['age'] = _age;
    map['extra'] = _extra;
    map['namehospitail'] = _namehospitail;
    map['uid'] = _uid;
    return map;
  }
}
