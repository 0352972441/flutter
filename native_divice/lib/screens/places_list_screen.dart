import 'package:flutter/material.dart';
import 'package:native_divice/provider/great_places.dart';
import 'package:native_divice/screens/place_detail_screen.dart';
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
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).fetchData(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  builder: (context, greatPlace, ch) =>
                      greatPlace.items.length <= 0
                          ? ch
                          : ListView.builder(
                              padding: EdgeInsets.all(5),
                              itemCount: greatPlace.items.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                          greatPlace.items[index].image),
                                      radius: 30,
                                    ),
                                    title: Text(greatPlace.items[index].title),
                                    onTap: () => Navigator.pushNamed(
                                        context, PlaceDetailScreen.routeName),
                                  ),
                                );
                              },
                            ),
                  child: const Center(child: Text("You don't take picture")),
                ),
        ));
  }
}
