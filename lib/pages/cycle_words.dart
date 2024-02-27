import 'package:dict_daily/domain/widgets/dict_word_widget.dart';
import 'package:flutter/material.dart';
import 'package:dict_daily/main.dart';
import 'package:provider/provider.dart';

class CycleWordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var currentDictWord = appState.currentWord;

    IconData icon = appState.isInFavourites(currentDictWord)
        ? Icons.favorite
        : Icons.favorite_border;

    return Container(
      padding: EdgeInsets.all(15),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          DictWordWidget(currentDictWord),
          Expanded(
            child: SizedBox(height: 10),
          ),
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
