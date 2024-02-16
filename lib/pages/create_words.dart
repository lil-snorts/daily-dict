import 'package:flutter/material.dart';
import 'package:maxtrackr_flutter/main.dart';
import 'package:provider/provider.dart';

class WordGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var curStr = appState.currentWord;

    IconData icon = appState.isInFavourites(curStr)
        ? Icons.favorite
        : Icons.favorite_border;

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  curStr.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(curStr.pronounciation),
                SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: curStr.descriptions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(curStr.descriptions[index]),
                        );
                      },
                    )),
              ],
            ),
          ),
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
