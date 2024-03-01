import 'package:dict_daily/integration/database/database_helper.dart';
import 'package:dict_daily/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return FutureBuilder(
        future: DatabaseHelper.instance.favouriteContains(appState.currentWord),
        builder: (context, snapshot) {
          return ElevatedButton.icon(
            onPressed: () {
              appState.toggleFavorite(appState.currentWord);
            },
            icon: snapshot.hasData
                ? snapshot.data!
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border)
                : Icon(Icons.time_to_leave),
            label: Text('Like'),
          );
        });
  }
}
