import 'package:flutter/foundation.dart';

class Cart {
  final String title;
  final double price;
  final String id;
  final int quantity;

  Cart(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}
