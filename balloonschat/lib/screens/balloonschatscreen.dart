import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BalloonsChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("chats/DOfbgW3z1Oa8soAh8BgU/messager")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data.documents;
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: Text(documents[index]['user']),
                ),
              );
            },
            itemCount: documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection("chats/DOfbgW3z1Oa8soAh8BgU/messager")
              .add({
            "user": "What your name?",
          });
        },
        child: Icon(Icons.beach_access),
      ),
    );
  }
}

/**
 * // Firestore.instance
          //     .collection('chats')
          //     .getDocuments()
          //     .then((value) => {
          //           value.documents.forEach((element) {
          //             print('Value: ${element.data['name']}');
          //           })
          //         });
          Firestore.instance
              .collection('/chats/DOfbgW3z1Oa8soAh8BgU/messager')
              .snapshots()
              .listen((event) {
            event.documents.forEach((element) {
              print('Value: ${element['user']}');
            });
          });
        },
 */
