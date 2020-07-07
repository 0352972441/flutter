import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';
import '../DUMMY_PRODUCT.dart';

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

  void addProduct(Product product) {
    _item.add(product);
    notifyListeners();
  }
}
