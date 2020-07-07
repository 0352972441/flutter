import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final int amount;
  final Widget child;
  final Color color;

  Badge(this.child, this.amount, this.color);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color:
                  color != null ? Colors.blue : Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              amount.toString(),
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
