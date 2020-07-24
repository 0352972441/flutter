import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BalloonsChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text("do something ..."),
            ),
          );
        },
        itemCount: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection('chats/AIU4zarTxXhPG9LBvVq6/name')
              .snapshots()
              .listen((event) {
            print(event);
          });
        },
        child: Icon(Icons.beach_access),
      ),
    );
  }
}
