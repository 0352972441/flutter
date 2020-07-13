import 'package:flutter/material.dart';
import 'package:login/screens/homelogin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(
        accentColor: Colors.white,
        primarySwatch: Colors.green,
        textTheme: TextTheme(
            title: TextStyle(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 18)),
      ),
      home: HomeLogin(),
    );
  }
}
