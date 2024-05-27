import 'package:flutter/cupertino.dart';
class Hospitail {
  Hospitail({
    String? id,
    String? address,
    int ? number,
    String? price,
    String? des,

    String? namehospitail,


    String? uid,
    double? latitude,
    double? logtitude,
  }) {
    _id = id;
    _address = address;
    _number=number;
    _price=price;
    _des=des;
    _namehospitail = namehospitail;
    _uid = uid;
    _latitude = latitude;
    _logtitude=logtitude;
  }

  Hospitail.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
    _price = json['price'];
    _des = json['des'];
    _address = json['address'];
    _latitude = json['latitude'];
    _namehospitail = json['namehospitail'];
    _logtitude = json['logtitude'];
    _uid = json['uid'];
  }

  String? _id;

  String? _address;
  double? _latitude;
  double? _logtitude;
  String? _namehospitail;

  String? _uid;
  int? _number;
  String? _price;
  String? _des;


  String? get id => _id;
  String? get address => _address;
  double? get latitude=> _latitude;
  double? get logtitude => _logtitude;
  int? get number => _number;
  String? get price=> _price;
  String? get des=> des;
  String? get namehospitail => _namehospitail;
  String? get uid => _uid;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['address'] = _address;
    map['logtitude'] = _logtitude;
    map['latitude'] = _latitude;
    map['namehospitail'] = _namehospitail;
    map['number'] = _number;
    map['price'] = _price;
    map['des'] = _des;
    map['uid'] = _uid;
    return map;
  }
}

