import 'package:flutter/material.dart';

class DictWord extends StatelessWidget {
  final String name;
  final String pronounciation;
  final List<String> descriptions;

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
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            pronounciation,
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: ListView.builder(
                  itemCount: descriptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(descriptions[index]));
                  })),
        ],
      ),
    );
  }
}
