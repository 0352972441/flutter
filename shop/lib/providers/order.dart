import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import '../models/order_item.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Order extends ChangeNotifier {
  List<OrderItem> _orders = [];
  final String _token;
  List<OrderItem> get order {
    return [..._orders];
  }

  Order(this._token, this._orders);

  Future<void> fetchDatabase() async {
    final URL = "${DotEnv().env['URL']}/order.json?auth=$_token";
    final response = await http.get(URL);
    final List<OrderItem> orderLoading = [];
    final extraData = json.decode(response.body) as Map<String, dynamic>;

    extraData.forEach((orderId, orderData) {
      orderLoading.add(OrderItem(
        id: orderId,
        dateTime: DateTime.parse(orderData["dateTime"]),
        total: orderData["total"],
        product: (orderData["product"] as List<dynamic>).map((value) {
          return Cart(
              id: value['id'],
              title: value['title'], //value['title'],
              price: value['price'],
              quantity: value['quantity']);
        }).toList(),
      ));
    });

    _orders = orderLoading.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(double total, List<Cart> product) async {
    final URL = "${DotEnv().env['URL']}/order.json?auth=$_token";
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(URL,
          body: json.encode({
            "total": total,
            'dateTime':
                /*DateFormat()
                .add_yMMMd()
                .format(DateTime.now())*/
                timeStamp.toIso8601String(),
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
