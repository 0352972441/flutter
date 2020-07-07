import 'package:flutter/foundation.dart';
import '../models/cart.dart';

class OrderItem {
  final String id;
  final DateTime dateTime;
  final List<Cart> product;
  final double total;

  OrderItem(
      {@required this.id,
      @required this.dateTime,
      @required this.product,
      @required this.total});
}
