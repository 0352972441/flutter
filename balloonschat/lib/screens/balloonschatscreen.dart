import 'package:balloonschat/Chats/messages.dart';
import 'package:balloonschat/Chats/newmessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BalloonsChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Balloons"),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(
              Icons.menu,
              color: Colors.green,
            ),
            items: [
              DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Icon(Icons.exit_to_app),
                  ))
            ],
            onChanged: (value) {
              if (value == "logout") {
                print("logout");
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[Expanded(child: Messages()), NewMessages()],
      )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Firestore.instance
      //         .collection("chats/DOfbgW3z1Oa8soAh8BgU/messager")
      //         .add({
      //       "user": "What your name?",
      //     });
      //   },
      //   child: Icon(Icons.beach_access),
      // ),
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
