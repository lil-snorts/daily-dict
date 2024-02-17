import 'package:flutter/material.dart';
import 'package:maxtrackr_flutter/main.dart';
import 'package:provider/provider.dart';

class WordGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentDictWord = appState.currentWord;

    IconData icon = appState.isInFavourites(currentDictWord)
        ? Icons.favorite
        : Icons.favorite_border;

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currentDictWord,
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite(currentDictWord);
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNextWord();
                },
                child: Text('Next'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getRandomWord();
                },
                child: Text('Random'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
