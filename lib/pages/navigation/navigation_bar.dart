import 'package:flutter/material.dart';
import 'package:dict_daily/main.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return NavigationBar(
      onDestinationSelected: (int index) {
        appState.changePage(index);
      },
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
      selectedIndex: appState.selectedPageIndex,
    );
  }
}
