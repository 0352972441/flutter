import 'package:balloonschat/Chats/messages_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return MessagesBubble(chatDocs[index]['text']);
            // return Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20)),
            //   child: Padding(
            //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //       child: Text(
            //         chatDocs[index]['text'],
            //         softWrap: true,
            //       )),
            // );
          },
        );
      },
    );
  }
}
