import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carts.dart';

class CartItem extends StatelessWidget {
  final String keyItem;
  final String title;
  final String id;
  final double price;
  final int quantity;
  bool isCheck = false;
  CartItem(this.keyItem, this.id, this.price, this.quantity, this.title);
  @override
  Widget build(BuildContext context) {
    print('Cart Item');
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 45,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 50),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are you sure ?"),
              content: Text("Do you want remove item from cart ?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("OK")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      // Navigator.pop(context, false);
                    },
                    child: Text("Cancel")),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        print("True is Remote");
        Provider.of<Carts>(context, listen: false).remove(keyItem);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 24,
              child: Padding(
                  padding: EdgeInsets.all(4),
                  child: FittedBox(child: Text('\$${price}'))),
            ),
            title: Text(title),
            subtitle: Text('total: \$${price * quantity}'),
            trailing: Text('x ${quantity} '),
          ),
        ),
      ),
    );
  }
}
