import 'package:flutter/material.dart';
import 'package:maxtrackr_flutter/main.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text("No favourite words as of yet"),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("You have ${appState.favorites.length} favourites"),
        ),
        for (var word in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(word.name),
          ),
      ],
    );
  }
}
