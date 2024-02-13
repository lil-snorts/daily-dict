import 'package:flutter/material.dart';

class DictWord extends Widget {
  String name;
  String pronounciation;
  List<String> descriptions;

  DictWord(
      {required this.name,
      required this.pronounciation,
      required this.descriptions});

  factory DictWord.fromJson(Map<String, dynamic> json) {
    return DictWord(
      name: json['Name'],
      pronounciation: json['Pronounciation'],
      descriptions: List<String>.from(json['Descriptions']),
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Pronounciation': pronounciation,
        'Descriptions': descriptions,
      };

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}
