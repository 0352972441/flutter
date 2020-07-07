import 'package:flutter/cupertino.dart';
import '../models/order_item.dart';
import '../models/cart.dart';

class Order extends ChangeNotifier {
  Map<String, OrderItem> _orders = {};

  Map<String, OrderItem> get order {
    return {..._orders};
  }

  void addOrder(String key, double total, List<Cart> product) {
    _orders.putIfAbsent(
        key,
        () => OrderItem(
            id: DateTime.now().toString(),
            dateTime: DateTime.now(),
            product: product,
            total: total));
    notifyListeners();
  }
}
