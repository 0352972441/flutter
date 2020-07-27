import 'package:flutter/material.dart';

class MessagesBubble extends StatelessWidget {
  final String _message;
  final bool isMe;
  final Key key;
  final String userName;
  MessagesBubble(this._message, this.isMe, this.userName, {this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              child: Text(
                userName,
                style: TextStyle(fontSize: 12, color: Colors.blueGrey[200]),
              ),
              padding:
                  isMe ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
            ),
            Container(
              width: 270,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.only(left: 10, top: 6, right: 6, bottom: 6),
              decoration: BoxDecoration(
                color: !isMe ? Colors.green[100] : Colors.blueAccent[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  _message,
                  style: TextStyle(
                      fontSize: 16,
                      color: isMe ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
