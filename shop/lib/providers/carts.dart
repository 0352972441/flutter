import 'package:flutter/cupertino.dart';

import '../models/cart.dart';

class Carts with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get item {
    return {..._items};
  }

  get size {
    return _items.length;
  }

  get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void remove(String key) {
    _items.remove(key);
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (value) => Cart(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
      // nếu trong map tồn tại id thì tăng Số lượng
    } else {
      // Nếu id không tồn tại thì thêm product vào sản phẩm
      _items.putIfAbsent(
          productId,
          () => Cart(
              id: DateTime.now().toString(),
              price: price,
              title: title,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeSingle(String productId) {
    // if(_items.containsKey(productId)){

    // }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (Cart value) => Cart(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      remove(productId);
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
