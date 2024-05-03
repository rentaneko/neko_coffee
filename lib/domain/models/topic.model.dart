import 'dart:convert';
import 'package:neko_coffee/core/entities/topic.dart';

class TopicModel extends Topic {
  TopicModel({required super.id, required super.title});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory TopicModel.fromMap(Map<String, dynamic> map) {
    return TopicModel(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicModel.fromJson(String source) =>
      TopicModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
