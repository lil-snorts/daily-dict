import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dict_daily/domain/widgets/dict_word_widget.dart';
import 'package:dict_daily/pages/home_page.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  const String wordsDatabase = 'words';
  // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), '$wordsDatabase.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
          'CREATE TABLE words(id INTEGER PRIMARY KEY, name TEXT, pronounciation TEXT, descriptions INTEGER)'
          'CREATE TABLE favs(id INTEGER PRIMARY KEY, word_id INTEGER, FOREIGN KEY (word_id) REFERENCES words(id) ON DELETE CASCADE)');
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

// Define a function that inserts dogs into the database
  Future<void> insertDog(DictWord wordToInsert) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      wordsDatabase,
      wordToInsert.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

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
  // generate the words on start up
  _generate();
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
  void toggleFavorite(DictWord current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    print(favorites);

    notifyListeners();
  }

  // check favourites DB
  bool isInFavourites(DictWord current) {
    return favorites.contains(current);
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
    if (words.isEmpty) {
      print("words empty; generating words");
      _generate().whenComplete(() => _updateCurrentWordAndNotify());
    } else {
      _updateCurrentWordAndNotify();
    }
  }

  // maybe obsoleted?
  void _updateCurrentWordAndNotify() {
    currentWord = words[currentWordIndex++];
    print(currentWordIndex);
    // so we dont repeat words, ever
    words.remove(currentWord);
    notifyListeners();
  }

  // get from db dictionary
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
      var id = 0;

      for (dynamic obj in dictionary) {
        words.add(DictWord.fromJson(id++, obj));
      }
      print("done");
    } catch (error) {
      print("Error reading the file: $error");
    }
  }
}
