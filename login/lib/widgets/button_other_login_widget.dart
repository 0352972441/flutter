import 'package:flutter/material.dart';

class ButtonOtherLoginWidget extends StatelessWidget {
  final String image;
  final Function selectedIcon;
  ButtonOtherLoginWidget(this.image, this.selectedIcon);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          //border: Border.all(width: 2, color: color),
        ),
        child: IconButton(
            icon: Image.asset(
              image,
            ),
            onPressed: selectedIcon));
  }
}
