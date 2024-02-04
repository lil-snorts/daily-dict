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
        title: 'Namer App',
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
  var words = <String>{};
  var selectedPageIndex = 0;
  var currentWord = "Click 'Next'";

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

  void getNext() {
    if (words.isEmpty) {
      var gen = generate();
      currentWord = "loading swag...";
      notifyListeners();
      gen.whenComplete(() => getNextWordFromSet());
      return;
    } else {
      getNextWordFromSet();
    }
  }

  void getNextWordFromSet() {
    print(words.first);
    currentWord = words.first;
    words.remove(currentWord);
    notifyListeners();
  }

  Future<void> generate() async {
    try {
      if (words.isNotEmpty) return;

      File file = File('lib/resources/dictonary.txt');
      List<String> lines = await file.readAsLines();
      // Define the regex pattern
      RegExp regex = RegExp(r'^[A-Z][A-Z0-9\. -]*$');

      // Iterate through each line and print lines that match the regex
      for (String line in lines) {
        if (regex.hasMatch(line)) {
          words.add(line);
          // print(line);
          //  break; // to stop at that word
        }
      }
      print("done");
    } catch (e) {
      print("Error reading the file: $e");
    }
  }
}
