import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maxtrackr_flutter/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// https://codelabs.developers.google.com/codelabs/flutter-codelab-first#6

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Daily Dic',
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
  var favorites = <String>{};
  var words = <String>[];
  var selectedPageIndex = 0;
  var currentWordIndex = 0;
  var currentWord = "Click 'Next'";

  void changePage(int index) {
    selectedPageIndex = index;
    notifyListeners();
  }

  void toggleFavorite(String current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    print(favorites);

    notifyListeners();
  }

  bool isInFavourites(String current) {
    return favorites.contains(current);
  }

  Future<void> _generate() {
    var gen = _loadFromDictionary();
    currentWordIndex = 0;
    currentWord = "loading swag...";
    notifyListeners();
    return gen;
  }

  void getNextWord() {
    if (words.isEmpty) {
      _generate().whenComplete(() => _updateCurrentWordAndNotify());
    } else {
      _updateCurrentWordAndNotify();
    }
  }

  void _updateCurrentWordAndNotify() {
    currentWord = words[currentWordIndex++];
    // so we dont repeat words, ever
    words.remove(currentWord);
    notifyListeners();
  }

  void getRandomWord() {
    currentWordIndex = Random().nextInt(words.length);
    getNextWord();
  }

  Future<void> _loadFromDictionary() async {
    try {
      if (words.isNotEmpty) return;

      File file = File('lib/resources/dictonary.txt');
      List<String> lines = await file.readAsLines();
      // Define the regex pattern
      RegExp regex = RegExp(r'^[A-Z][A-Z0-9\. -]*$');

      // Iterate through each line and print lines that match the regex

      for (String line in lines) {
        if (regex.hasMatch(line)) {
          if (words.isEmpty ||
              words.isNotEmpty && words[words.length - 1] != line) {
            words.add(line);
            // print("unique $line");
            // print(line);
            // to stop at that word
            //  break;
          } else {
            // print("duplicate $line");
          }
        }
      }
      print("done");
    } catch (e) {
      print("Error reading the file: $e");
    }
  }
}
