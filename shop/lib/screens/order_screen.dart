import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/drawers.dart';
import '../providers/order.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const String ROUTENAME = '/orderscreen';

  // @override
  // void initState() {
  //   setState(() {
  //     widget._isLoading = true;
  //   });
  //   Future.delayed(Duration.zero).then((value) async => {
  //         await Provider.of<Order>(context, listen: false)
  //             .fetchDatabase()
  //             .then((value) {
  //           setState(() {
  //             widget._isLoading = false;
  //           });
  //         })
  //       });
  //   super.initState();
  // }
  // bool _ischeck = true;
  // @override
  // void didChangeDependencies() {
  //   if (_ischeck) {
  //     Provider.of<Order>(context, listen: false)
  //         .fetchDatabase()
  //         .then((value) => print("Ok"));
  //   }
  //   _ischeck = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    print("Chạy Lại");
    //final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My Order')),
      drawer: MyDrawer(),
      body: FutureBuilder(
        future: Provider.of<Order>(context, listen: false).fetchDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Text("Error");
            } else {
              return Consumer<Order>(
                builder: (context, orderData, child) {
                  return ListView.builder(
                    itemCount: orderData.order.length,
                    itemBuilder: (context, index) {
                      return OrderItem(orderData.order[index]);
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
