import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/Auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    void _sumitRegister(String email, String userName, String password,
        bool isLogin, BuildContext context, File _image) async {
      setState(() {
        _isLoading = true;
      });
      AuthResult authResult;
      try {
        if (isLogin) {
          authResult = await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
        } else {
          authResult = await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          final ref = FirebaseStorage.instance
              .ref()
              .child("user_image")
              .child(authResult.user.uid + '.jpg');
          await ref.putFile(_image).onComplete;
          await Firestore.instance
              .collection('user')
              .document(authResult.user.uid)
              .setData(
                  {'email': email, 'password': password, 'userName': userName});
        }
        setState(() {
          _isLoading = false;
        });
      } on PlatformException catch (error) {
        String message = "";
        if (error.message != null) {
          print(error.details);
          message = error.message;
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Auth(_sumitRegister, _isLoading),
    );
  }
}
