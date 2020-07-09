import 'package:flutter/material.dart';

class MyFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        child: Text("Ehezz"),
        radius: 50,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
