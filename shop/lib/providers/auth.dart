import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  Future<void> _authenticate(
      String email, String password, String urlsegment) async {
    final URL =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyDmN79jMNWljfPahD1lvVdh8Yrg6AkiGLg";
    final response = await http.post(URL,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    print(response.body);
  }

  Future<void> signUp(String email, String password) {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) {
    _authenticate(email, password, "signInWithPassword");
  }
}
//signInWithPassword
