import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/drawers.dart';
import '../providers/order.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const String ROUTENAME = '/orderscreen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My Order')),
      drawer: MyDrawer(),
      body: ListView.builder(
        itemCount: orderData.order.length,
        itemBuilder: (context, index) {
          return OrderItem(orderData.order[index]);
        },
      ),
    );
  }
}
