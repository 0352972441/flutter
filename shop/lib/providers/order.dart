import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import '../models/order_item.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;

class Order extends ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get order {
    return [..._orders];
  }

  Future<void> addOrder(double total, List<Cart> product) async {
    const URL = "https://flutter-update-a40ab.firebaseio.com/order.json";
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(URL,
          body: json.encode({
            "total": total,
            'dateTime': DateFormat()
                .add_yMMMd()
                .format(DateTime.now()) /*timeStamp.toIso8601String()*/,
            "product": product
                .map((value) => {
                      "id": value.id,
                      "quantity": value.quantity,
                      "price": value.price,
                      "title": value.title
                    })
                .toList()
          }));
      _orders.add(OrderItem(
          id: json.decode(response.body)['name'],
          dateTime: timeStamp,
          product: product,
          total: total));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
