import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maxtrackr_flutter/main.dart';
import 'package:maxtrackr_flutter/pages/create_words.dart';
import 'package:maxtrackr_flutter/pages/navigation/navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = WordGeneratorPage();
      case 1:
        page = FavouritesPage();
      default:
        throw UnimplementedError("no widget for $selectedIndex");
    }

    return Scaffold(
      body: Row(
        children: [
          NavBar(),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}
