import 'package:flutter/material.dart';
import 'package:maxtrackr_flutter/main.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return SafeArea(
      child: NavigationRail(
        extended: false,
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.favorite),
            label: Text('Favorites'),
          ),
        ],
        selectedIndex: appState.selectedPageIndex,
        onDestinationSelected: (value) {
          appState.selectedPageIndex = value;
        },
      ),
    );
  }
}
