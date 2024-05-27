import 'package:flutter/cupertino.dart';


class Shaqa {
  Shaqa({
    String? id,
    String? shaqa,





    String? uid,


  }) {
    _id = id;
    _shaqa= shaqa;

    _uid = uid;

  }

  Shaqa.fromJson(dynamic json) {
    _id = json['id'];
    _shaqa = json['shaqa'];


    _uid = json['uid'];
  }

  String? _id;
  String? _shaqa;



  String? _uid;


  String? get id => _id;
  String? get  shaqa=> _shaqa;

  String? get uid => _uid;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shaqa'] = _shaqa;
   ;

    map['uid'] = _uid;
    return map;
  }
}
