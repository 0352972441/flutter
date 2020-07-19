import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/httpException.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth extends ChangeNotifier {
  String _idToken; // Id token tạo bởi firebase cho người dùng mới được tạo
  DateTime _expiresIn; // Số giây mà Mà id tonken hết hạn
  String _localId; // Uid cho người dùng mới được tạo

  bool isAuth() {
    return token != null;
  }

  String get token {
    if (_expiresIn != null &&
        _idToken != null &&
        _expiresIn.isAfter(DateTime.now())) {
      // Nếu idtoken và ngày hết hạn bằng khác null và cái thời gian hết hạn của token
      // mà sau ngày hiện tại (vd: thời gian hiện tại là (3h30s) Khi signup là thời gian hết hạn token là 3h60s => thời gian hiện tại vượt qua 3h60 là hết hạn)
      return _idToken;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlsegment) async {
    final URL =
        "${DotEnv().env['AUTHURL']}$urlsegment?key=${DotEnv().env['KEYAUTH']}";
//https://identitytoolkit.googleapis.com/v1/accounts:
//AIzaSyDmN79jMNWljfPahD1lvVdh8Yrg6AkiGLg
    try {
      final response = await http.post(URL,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      print(response.body);
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _idToken = responseData[
          'idToken']; // idToken là key được quy định chung (firebase)
      _expiresIn = DateTime.now().add(Duration(
          seconds: int.parse(responseData[
              "expiresIn"]))); // Thời gian hiện tại công thêm thời gian hết hạn
      _localId = responseData["_localId"];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) {
    return _authenticate(email, password, "signInWithPassword");
  }
}
//signInWithPassword
