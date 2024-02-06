import 'package:flutter/material.dart';
import 'package:maxtrackr_flutter/main.dart';
import 'package:maxtrackr_flutter/pages/create_words.dart';
import 'package:maxtrackr_flutter/pages/favourites_page.dart';
import 'package:maxtrackr_flutter/pages/navigation/navigation_bar.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Widget page;
    switch (appState.selectedPageIndex) {
      case 0:
        page = WordGeneratorPage();
      case 1:
        page = FavouritesPage();
      default:
        throw UnimplementedError("no widget for $appState.selectedPageIndex");
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
          NavBar(),
        ],
      ),
    );
  }
}
