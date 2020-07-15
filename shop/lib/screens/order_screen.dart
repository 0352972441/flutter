import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/drawers.dart';
import '../providers/order.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const String ROUTENAME = '/orderscreen';
  bool _isLoading = false;
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((value) async =>
  //       {await Provider.of<Order>(context, listen: false).fetchDatabase()});
  //   super.initState();
  // }
  bool _ischeck = true;
  @override
  void didChangeDependencies() {
    if (_ischeck) {
      Provider.of<Order>(context, listen: false)
          .fetchDatabase()
          .then((value) => print("Ok"));
    }
    _ischeck = false;
    super.didChangeDependencies();
  }

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
