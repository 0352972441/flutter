import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tab/Screens/homescreen.dart';

void main() => runApp(MyHome());

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Tab bar', home: HomeScreen());
  }
}
