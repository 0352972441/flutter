import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routerName = "homepage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset("assets/images/pass.png"),
      ),
    );
  }
}
