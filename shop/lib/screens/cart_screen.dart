import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carts.dart';
import '../widgets/cart_item.dart';
import '../providers/order.dart';

class CartScreen extends StatelessWidget {
  static const String ROUTERNAME = "/cartscreen";
  @override
  Widget build(BuildContext context) {
    print('Cart Screen');

    final cartItem = Provider.of<Carts>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total: ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Colors.green,
                    label: Text(
                      '\$${cartItem.totalAmount}',
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      final _oderItem =
                          Provider.of<Order>(context, listen: false);
                      _oderItem.addOrder(
                        UniqueKey().toString(),
                        cartItem.totalAmount,
                        cartItem.item.values.toList(),
                      );
                      cartItem.clear();
                    },
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return CartItem(
                  cartItem.item.keys.toList()[index],
                  cartItem.item.values.toList()[index].id,
                  cartItem.item.values.toList()[index].price,
                  cartItem.item.values.toList()[index].quantity,
                  cartItem.item.values.toList()[index].title);
            },
            itemCount: cartItem.size,
          ))
        ],
      ),
    );
  }
}
