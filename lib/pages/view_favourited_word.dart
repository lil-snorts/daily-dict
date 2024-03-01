import 'package:dict_daily/domain/widgets/dict_word_widget.dart';
import 'package:dict_daily/domain/widgets/favourite_button_widget.dart';
import 'package:dict_daily/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritedWordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(15),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                DictWordWidget(appState.currentWord),
                Expanded(
                  child: SizedBox(height: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FavouriteButton(),
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
