import 'package:flutter/material.dart';
import 'package:maxtrackr_flutter/main.dart';
import 'package:maxtrackr_flutter/widgets/big_card.dart';
import 'package:provider/provider.dart';

class WordGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var curStr = appState.currentWord;

    IconData icon = appState.isInFavourites(curStr)
        ? Icons.favorite
        : Icons.favorite_border;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: curStr),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite(curStr);
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
