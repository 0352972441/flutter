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
                      '\$${cartItem.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                  ),
                  OrderButton(cartItem: cartItem),
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

class OrderButton extends StatefulWidget {
  bool isLoading = false;
  OrderButton({
    Key key,
    @required this.cartItem,
  }) : super(key: key);

  final Carts cartItem;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Theme.of(context).primaryColor,
      onPressed: widget.cartItem.totalAmount <= 0
          ? null
          : () async {
              setState(() {
                widget.isLoading = true;
              });
              await Provider.of<Order>(context, listen: false)
                  .addOrder(
                    widget.cartItem.totalAmount,
                    widget.cartItem.item.values.toList(),
                  )
                  .then((value) => {
                        setState(() {
                          widget.isLoading = false;
                        })
                      });
              widget.cartItem.clear();
            },
      child: widget.isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(color: Colors.purple),
            ),
    );
  }
}
