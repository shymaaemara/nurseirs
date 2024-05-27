import 'package:flutter/cupertino.dart';


class Hospitaildetailes {
  Hospitaildetailes({
    String? id,
    int? number,


    String? price,

    double? latitude,
    double? logtitude,
    String? uid,
    String? des,

  }) {
    _id = id;
    _number= number;
    _price =  price;
    _uid = uid;
    _des = des;
    _latitude = latitude;
    _logtitude=logtitude;
  }

  Hospitaildetailes.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
    _price = json['price'];
    _des= json['des'];
    _latitude = json['latitude'];
    _logtitude =json['logtitude'];
    _uid = json['uid'];
  }

  String? _id;
  int? _number;
  String?  _price;
  String? _des;

  double? _latitude;
  double? _logtitude;
  String? _uid;


  String? get id => _id;
  int? get number => _number;
  String? get price=> _price;
  String? get  des => _des;
  String? get uid => _uid;
  double? get latitude=> _latitude;
  double? get logtitude => _logtitude;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['number'] = _number;
    map['price'] = _price;
    map['des'] = _des;
    map['logtitude'] = _logtitude;
    map['latitude'] = _latitude;
    map['uid'] = _uid;
    return map;
  }
}
