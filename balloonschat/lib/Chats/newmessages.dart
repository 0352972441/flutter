import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatelessWidget {
  final _messageControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _messageControler,
            decoration: InputDecoration(
                //labelText: "Enter a messages",
                hintText: "Enter a message",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                        style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.green,
                        width: 1,
                        style: BorderStyle.solid))),
          )),
          IconButton(
              icon: Icon(
                Icons.send,
                size: 35,
                color: Colors.blue,
              ),
              onPressed: () async {
                final user = await FirebaseAuth.instance.currentUser();
                Firestore.instance.collection('chat').document().setData({
                  'text': _messageControler.text,
                  'createAt': Timestamp.now(),
                  'userId': user.uid,
                  'userName': (await Firestore.instance
                      .collection('user')
                      .document(user.uid)
                      .get())['userName'],
                });
                _messageControler.clear();
              })
        ],
      ),
    );
  }
}
