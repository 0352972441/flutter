import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String ROUTENAME = "/productdetail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final Product product =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        product.title,
      )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors
                  .blueGrey, //LieanrGradient//Gradient.linear(Alignment.topLeft, Alignment.bottomRight, Colors.blue),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              elevation: 6,
              child: Container(
                // decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.all(2),
                width: double.infinity,
                child: Text(
                  '\$${product.price}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                product.description,
                style: TextStyle(fontSize: 20),
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
