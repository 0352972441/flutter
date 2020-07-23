import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addSinglePlace(String title, File image) {
    final place = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: null);
    if (place == null) {
      return;
    }
    _items.add(place);
    notifyListeners();
  }
}
