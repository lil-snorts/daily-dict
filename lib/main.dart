import 'dart:math';
import 'dart:io';

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
  var selectedPageIndex = 0;
  var current = "";
  // Replace 'your_file.txt' with the path to your .txt file
  String filePath = 'lib/resources/dictonary.txt';

  // Process.run("echo", ['-e', "\$PWD"]);
  @override
  void initState() {
    try {
      File file = File(filePath);
      List<String> lines = file.readAsLinesSync();

      // Define the regex pattern
      RegExp regex = RegExp(r'^[A][A-Z0-9\. -]+$');

      // Iterate through each line and print lines that match the regex
      // for (String line in lines) {
      //   if (regex.hasMatch(line)) {
      //     print(line);
      //      break; // to stop at that word
      //   }
      // }
    } catch (e) {
      print("Error reading the file: $e");
    }
  }

  void getNext() {
    current = allWords.first;

    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    print(favorites);

    notifyListeners();
  }

  bool isInFavourites() {
    return favorites.contains(current);
  }
}
