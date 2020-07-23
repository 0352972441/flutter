import 'package:flutter/material.dart';
import 'package:native_divice/provider/great_places.dart';
import '../screens/add_places_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Save Great places beautiful"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () =>
                    Navigator.pushNamed(context, AddPlacesScreen.routeName))
          ],
        ),
        body: Consumer<GreatPlaces>(
          builder: (context, greatPlace, ch) => greatPlace.items.length <= 0
              ? ch
              : ListView.builder(
                  itemCount: greatPlace.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(greatPlace.items[index].title),
                    );
                  },
                ),
          child: const Center(child: Text("You don't take picture ")),
        ));
  }
}
