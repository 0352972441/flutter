import 'package:flutter/material.dart';

class MessagesBubble extends StatelessWidget {
  final String _message;
  MessagesBubble(this._message);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 270,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(left: 10, top: 6, right: 6, bottom: 6),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Text(
              _message,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
