import 'package:flutter/material.dart';
import './provider/great_places.dart';
import './screens/places_list_screen.dart';
import 'package:provider/provider.dart';
import './screens/add_places_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Native App",
        theme: ThemeData(
          accentColor: Colors.green,
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
            create: (context) => GreatPlaces(), child: PlacesListScreen()),
        routes: {
          AddPlacesScreen.routeName: (context) => AddPlacesScreen(),
        });
  }
}
