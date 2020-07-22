import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/customAnimation.dart';
import '../models/order_item.dart' as order;

class OrderItem extends StatefulWidget {
  final order.OrderItem orderData;
  OrderItem(this.orderData);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  AnimationController _controller;
  Animation<double> opacityAnimation;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    opacityAnimation = CustomAnimation.animations(_controller);
  }

  @override
  Widget build(BuildContext context) {
    print('Order Item');
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(top: 3),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: <Widget>[
              ListTile(
                  title: Text(
                    '\$${widget.orderData.total.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.red),
                  ),
                  subtitle: Text(
                    DateFormat('dd - mm - yyyy hh:mm')
                        .format(widget.orderData.dateTime),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.expand_more,
                        size: 30,
                        color: Colors.cyan,
                      ),
                      onPressed: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      })),
              SizedBox(
                height: 25,
              ),
              //if (_expanded)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                    minHeight: _expanded ? 10 : 0,
                    maxHeight: _expanded
                        ? widget.orderData.product.length * 30.0 + 100
                        : 0),
                child: Container(
                  height: min(
                      widget.orderData.product.length * 30.0 + 100, 200), //200,
                  width: double.infinity,
                  child: ListView(
                      children: widget.orderData.product.map((value) {
                    return Card(
                        elevation: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                alignment: Alignment.center,
                                height: 55,
                                child: Text(
                                  value.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                      color: Colors.deepPurple),
                                )),
                            Spacer(),
                            Container(
                                padding: EdgeInsets.only(right: 25),
                                alignment: Alignment.centerRight,
                                //height: 55,
                                child: Text(
                                  '\$${value.price}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                      fontSize: 16),
                                )),
                            Container(
                                padding: EdgeInsets.only(right: 15),
                                alignment: Alignment.centerRight,
                                //height: 55,
                                child: Text(
                                  'x ${value.quantity}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey,
                                      fontSize: 18),
                                )),
                          ],
                        ));
                  }).toList()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*ListTile(
                        //title: Text('\$${value.price}'),
                        trailing: Text('x ${value.quantity}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        //leading: Text(value.title),
                        title: Text(
                          value.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Container(
                          child: Text('\$${value.price}'),
                        )),*/
