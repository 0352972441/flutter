import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String title;
  final double price;
  final String id;
  final String description;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleChangeFavorite(String id, String idToken) async {
    final existFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final URL =
        "https://flutter-update-a40ab.firebaseio.com/SanPham/$id.json?auth=$idToken";
    try {
      // final response =
      final response =
          await http.patch(URL, body: json.encode({"isFavorite": isFavorite}));
      if (response.statusCode >= 400) {
        isFavorite = existFavorite;
        notifyListeners();
      }
    } catch (error) {
      print("Không được rồi");
      isFavorite = existFavorite;
      notifyListeners();
    }
  }
}
