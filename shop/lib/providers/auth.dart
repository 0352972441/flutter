import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/httpException.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String _idToken; // Id token tạo bởi firebase cho người dùng mới được tạo
  DateTime _expiresIn; // Số giây mà Mà id tonken hết hạn
  String _localId; // Uid cho người dùng mới được tạo
  Timer resultTimer;
  bool isAuth() {
    return token != null;
  }

  String get localId {
    return _localId;
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
      _localId = responseData["localId"];
      autoLogout();
      final prefer = await SharedPreferences.getInstance();
      final userData = json.encode({
        "idToken": _idToken,
        "userId": localId,
        "expiresIn": _expiresIn.toIso8601String(),
      });
      prefer.setString('userData', userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autosignin() async {
    final perfer = await SharedPreferences.getInstance();
    if (!perfer.containsKey('userData')) {
      return false;
    }
    final extraData =
        json.decode(perfer.getString("userData")) as Map<String, Object>;
    final expiresIn = DateTime.parse(extraData['expiresIn']);
    if (expiresIn.isBefore(DateTime.now())) {
      return false;
    }
    _expiresIn = expiresIn;
    _localId = extraData['userId'];
    _idToken = extraData['idToken'];
    notifyListeners();
    autoLogout();
    print("Data  new ");
    return true;
  }

  Future<void> signUp(String email, String password) {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> logout() async {
    _idToken = null;
    _expiresIn = null;
    _localId = null;
    if (resultTimer != null) {
      resultTimer.cancel();
      resultTimer = null;
    }
    notifyListeners();
    final perfec = await SharedPreferences.getInstance();
    perfec.clear();
  }

  void autoLogout() {
    if (resultTimer != null) {
      resultTimer.cancel();
    }
    final timeExp = _expiresIn.difference(DateTime.now()).inSeconds;
    print("Time:$timeExp");
    resultTimer = Timer(Duration(seconds: timeExp), logout);
  }
}
//signInWithPassword
