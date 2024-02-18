import 'package:flutter/material.dart';
import 'package:dict_daily/main.dart';
import 'package:dict_daily/pages/cycle_words.dart';
import 'package:dict_daily/pages/favourites_page.dart';
import 'package:dict_daily/pages/navigation/navigation_bar.dart';
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

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: page),
            NavBar(),
          ],
        ),
      ),
    );
  }
}
