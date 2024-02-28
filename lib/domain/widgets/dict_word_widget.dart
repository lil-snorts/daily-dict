import 'package:flutter/material.dart';

class DictWord {
  final int id;
  final String name;
  final String pronounciation;
  final List<String> descriptions;

  DictWord(
      {required this.id,
      required this.name,
      required this.pronounciation,
      required this.descriptions});

  factory DictWord.fromJson(int id, Map<String, dynamic> json) {
    return DictWord(
      id: id,
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
  Map<String, Object?> toMap() {
    String descriptionsConcat = "";
    for (var s in descriptions) {
      descriptionsConcat += "$s⍩";
    }
    return {
      'id': id,
      'name': name,
      'pronounciation': pronounciation,
      'descriptions': descriptionsConcat
    };
  }
}

class DictWordWidget extends StatelessWidget {
  final DictWord word;
  DictWordWidget(this.word);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            word.name,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            word.pronounciation,
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
                  itemCount: word.descriptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(word.descriptions[index]));
                  })),
        ],
      ),
    );
  }
}
