import 'package:flutter/cupertino.dart';


class   Answer {
  Answer({
    String? id,
    String? answer,





    String? uid,


  }) {
    _id = id;
    _answer=answer ;

    _uid = uid;

  }

  Answer.fromJson(dynamic json) {
    _id = json['id'];
    _shaqa = json['shaqa'];
    _answer = json['answer'];

    _uid = json['uid'];
  }

  String? _id;
  String? _shaqa;
  String? _answer;


  String? _uid;


  String? get id => _id;
  String? get  shaqa=> _shaqa;
  String? get  answer=> _answer;
  String? get uid => _uid;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shaqa'] = _shaqa;
    map['answer'] = _answer;

    map['uid'] = _uid;
    return map;
  }
}
