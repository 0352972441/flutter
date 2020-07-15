import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';
import '../DUMMY_PRODUCT.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _item = DUMMY_PRODUCT.map((e) => e).toList();
  //bool _isCheck = false;

  get items {
    // if (_isCheck) {
    //   return _item.where((element) => element.isFavorite).toList();
    // }
    return [..._item];
  }

  get favorite {
    return _item.where((element) => element.isFavorite).toList();
  }

  findById(String id) {
    return _item.firstWhere((element) => element.id == id);
  }

  // void onlyFavorite() {
  //   _isCheck = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _isCheck = false;
  //   notifyListeners();
  // }

  Future<void> fetchDatabase() async {
    const URL = "https://flutter-update-a40ab.firebaseio.com/SanPham.json";
    try {
      final response = await http.get(URL);
      final extraData = json.decode(response.body) as Map<String, dynamic>;
      extraData.forEach((key, value) {
        _item.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl']));
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const URL = "https://flutter-update-a40ab.firebaseio.com/SanPham.json";
    try {
      final response = await http.post(URL,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "isFavorite": false
          }));

      final Product newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _item.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void remoteSingle(String id) {
    _item.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateSingleProduct(String id, newProduct) {
    final indexOldProduct = _item.indexWhere((element) => id == element.id);
    if (indexOldProduct >= 0) {
      _item[indexOldProduct] = newProduct;
      notifyListeners();
    }
  }
}
