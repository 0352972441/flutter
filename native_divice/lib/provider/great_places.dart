import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../models/place.dart';
import '../helpers/helper_sqlite.dart';

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
    _items.add(place);
    notifyListeners();
    HelperSQLite.insert("UserPlaces", {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
    });
    //print("add data");
  }

  Future<void> fetchData() async {
    final data = await HelperSQLite.fetchGetData("UserPlaces");
    _items = data.map((Map<String, Object> item) {
      return Place(
          id: item['id'],
          title: item['title'],
          location: null,
          image: File(item['image']));
    }).toList();
    print("getData");
    notifyListeners();
  }
}
