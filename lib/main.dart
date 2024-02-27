import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dict_daily/domain/widgets/dict_word_widget.dart';
import 'package:dict_daily/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Daily Dict',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(
                  122 + Random.secure().nextInt(122),
                  Random.secure().nextInt(255),
                  Random.secure().nextInt(255),
                  Random.secure().nextInt(255))),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var favorites = <DictWord>{};
  var words = <DictWord>[];
  var selectedPageIndex = 0;
  var currentWordIndex = 0;
  var currentWord = DictWord(
      name: "Click Next",
      pronounciation: "Cl'-ick N'eckts",
      descriptions: ["This will select a real word from the dictionary"]);

  void changePage(int index) {
    selectedPageIndex = index;
    notifyListeners();
  }

  void toggleFavorite(DictWord current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    print(favorites);

    notifyListeners();
  }

  bool isInFavourites(DictWord current) {
    return favorites.contains(current);
  }

  Future<void> _generate() {
    var gen = _loadFromDictionary();
    currentWordIndex = 0;
    notifyListeners();
    return gen;
  }

  void getNextWord() {
    if (words.isEmpty) {
      print("words empty; generating words");
      _generate().whenComplete(() => _updateCurrentWordAndNotify());
    } else {
      _updateCurrentWordAndNotify();
    }
  }

  void _updateCurrentWordAndNotify() {
    currentWord = words[currentWordIndex++];
    print(currentWordIndex);
    // so we dont repeat words, ever
    words.remove(currentWord);
    notifyListeners();
  }

  getRandomWord() {
    if (words.isEmpty) {
      _generate().then((value) {
        currentWordIndex = Random().nextInt(words.length);
        getNextWord();
      });
    } else {
      currentWordIndex = Random().nextInt(words.length);
      getNextWord();
    }
  }

  Future<void> _loadFromDictionary() async {
    try {
      if (words.isNotEmpty) return;
      String bundle =
          await rootBundle.loadString('assets/parsed_dictionary.json');
      List<dynamic> dictionary = json.decode(bundle);

      for (dynamic obj in dictionary) {
        words.add(DictWord.fromJson(obj));
      }
      print("done");
    } catch (error) {
      print("Error reading the file: $error");
    }
  }
}
