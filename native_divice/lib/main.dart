import 'package:flutter/material.dart';
import './provider/great_places.dart';
import './screens/places_list_screen.dart';
import 'package:provider/provider.dart';
import './screens/add_places_screen.dart';
import './screens/place_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
          title: "Native App",
          theme: ThemeData(
            accentColor: Colors.green,
            primarySwatch: Colors.blue,
          ),
          home: PlacesListScreen(),
          routes: {
            AddPlacesScreen.routeName: (ctx) => AddPlacesScreen(),
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
          }),
    );
  }
}
