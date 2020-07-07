import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
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

  void toggleChangeFavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

}