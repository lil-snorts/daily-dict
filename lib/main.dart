import 'dart:convert';
import 'dart:math';

import 'package:dict_daily/integration/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dict_daily/domain/widgets/dict_word_widget.dart';
import 'package:dict_daily/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
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

class AppState extends ChangeNotifier {
  String wordsDatabase = 'words';
  var db = DatabaseHelper.instance;

  Future<void> _insertWord(DictWord wordToInsert) async {
    // Get a reference to the database.
    await db.wordInsert(wordToInsert);
  }

  var selectedPageIndex = 0;
  var currentWordIndex = 0;
  var currentWord = DictWord(
      id: -1,
      name: "Click Next",
      pronounciation: "Cl'-ick N'eckts",
      descriptions: ["This will select a real word from the dictionary"]);

  void changePage(int index) {
    selectedPageIndex = index;
    notifyListeners();
  }

  // Switch the state of the favourite for the current word
  void toggleFavorite(DictWord viewedWord) {
    // query to see if the current word is in the database
    db.favouriteContains(viewedWord).then((value) => {
          if (value)
            db.favouriteRemove(viewedWord)
          else
            db.favouriteInsert(viewedWord)
        });

    notifyListeners();
  }

  // Check words DB
  Future<void> _generate() {
    var gen = _loadFromDictionary();
    currentWordIndex = -1;
    notifyListeners();
    return gen;
  }

  // Get the next word from the words DB using ID
  void getNextWord() {
    db.queryCountWords().then((output) => {
          if (output == 0)
            {_generate().whenComplete(() => _updateCurrentWordAndNotify())}
          else
            {_updateCurrentWordAndNotify()}
        });
  }

  // maybe obsoleted?
  void _updateCurrentWordAndNotify() {
    // currentWord = words[currentWordIndex++];
    // print(currentWordIndex);
    // // so we dont repeat words, ever
    // words.remove(currentWord);
    // notifyListeners();
  }

  // get from db dictionary
  getRandomWord() async {
    var count = await db.queryCountWords();
    if (count != null) {
      _generate().then((value) {
        currentWordIndex = Random().nextInt(count);
        getNextWord();
      });
    }
  }

  Future<void> _loadFromDictionary() async {
    try {
      var res = await db.queryCountWords();
      if (res != null) return;
      String bundle =
          await rootBundle.loadString('assets/parsed_dictionary.json');
      List<dynamic> dictionary = json.decode(bundle);
      var id = 0;

      for (dynamic obj in dictionary) {
        db.wordInsert(DictWord.fromJson(id++, obj));
      }
      print("done");
    } catch (error) {
      print("Error reading the file: $error");
    }
  }
}
