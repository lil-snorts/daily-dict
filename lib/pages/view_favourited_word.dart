import 'package:dict_daily/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritedWordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentDictWord = appState.currentWord;

    IconData icon = appState.isInFavourites(currentDictWord)
        ? Icons.favorite
        : Icons.favorite_border;

    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(15),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                currentDictWord,
                Expanded(
                  child: SizedBox(height: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        appState.toggleFavorite(currentDictWord);
                      },
                      icon: Icon(icon),
                      label: Text('Like'),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ElevatedButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.backspace),
                            label: Text('Backspace')))
                  ],
                ),
                Expanded(
                  child: SizedBox(height: 10),
                ),
              ],
            )));
  }
}
