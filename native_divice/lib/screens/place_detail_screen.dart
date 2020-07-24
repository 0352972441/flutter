import 'package:flutter/material.dart';
import 'package:native_divice/provider/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const String routeName = "/places-detail";
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<GreatPlaces>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Place detail screen"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Image.file(places.items[0].image),
              ),
            )
          ],
        ));
  }
}
