import 'package:dict_daily/domain/widgets/dict_word_widget.dart';
import 'package:dict_daily/integration/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:dict_daily/main.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.instance.favouritesGetAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is being fetched, return a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, display it
          return Text('Error: ${snapshot.error}');
        } else {
          // If data is successfully fetched, display it
          if (snapshot.data != null && !snapshot.data!.isNotEmpty) {
            List<Map<String, dynamic>> favourites = snapshot.data!;
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("You have ${favourites.length} favourites"),
                ),
                for (var wordMap in favourites)
                  GestureDetector(
                      onTap: () {
                        appState.currentWord = DictWord.fromJson(null, wordMap);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavouritesPage()));
                      },
                      child: ListTile(
                        leading: Icon(Icons.favorite),
                        title: Text(wordMap['Name']),
                      )),
              ],
            );
          } else {
            return Center(
              child: Text("No favourite words as of yet"),
            );
          }
        }
      },
    );
  }
}
