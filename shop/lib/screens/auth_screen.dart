import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/httpException.dart';
import 'package:shop/providers/auth.dart';
import '../models/httpException.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diveceSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   centerTitle: true,
      //   title: Text(""),
      // ),
      body: Stack(
        children: <Widget>[
          Container(
            width: diveceSize.width,
            height: diveceSize.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      // Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                      // Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                      Colors.blueGrey.withOpacity(0.5),
                      Colors.lightBlue.withOpacity(0.6),
                      Colors.lightBlueAccent.withOpacity(0.7)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1, 2])),
            child: SingleChildScrollView(
              child: Container(
                width: diveceSize.width,
                height: diveceSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 94),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow,
                          gradient: LinearGradient(colors: [
                            Colors.yellow,
                            Colors.yellowAccent,
                            Colors.green.withOpacity(0.9)
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black87,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: Text(
                          "My Shop",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.blue,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: AuthCard(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final _controlerPassword = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  final _focusPassword = FocusNode();
  bool _isLoading = false;
  Map<String, String> user = {"email": "", "password": ""};
  @override
  void dispose() {
    _controlerPassword.dispose();
    super.dispose();
  }

  void showDialogNotifier(message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titleTextStyle: TextStyle(color: Colors.purple),
          title: Text("An error Occurred"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text("OK"))
          ],
        );
      },
    );
  }

  Future<void> _onSumit() async {
    final validator = _globalKey.currentState.validate();
    if (!validator) {
      return;
    }
    _globalKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // do something login
        await Provider.of<Auth>(context, listen: false)
            .signIn(user['email'], user['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(user['email'], user['password']);
        //do something signup
      }
    } on HttpException catch (error) {
      var onMessage = "";
      if (error.toString().contains("EMAIL_NOT_FOUND")) {
        onMessage = "The email address is incorrect, Please check again ";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        onMessage = "Incorrrect password, Please try again later";
      } else if (error.toString().contains("USER_DISABLED")) {
        onMessage = "Account disabled , Please try again later";
      } else if (error.toString().contains("EMAIL_EXISTS")) {
        onMessage = "Email address already in use, Please try again ";
      } else if (error.toString().contains("OPERATION_NOT_ALLOWED")) {
        onMessage = "Password login is disable for this project";
      } else if (error.toString().contains("TOO_MANY_ATTEMPTS_TRY_LATER")) {
        onMessage =
            "We have blocked all requests from this device due to unusual activity. Try again later.";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        onMessage = "Invalid email, Please check again";
      }
      showDialogNotifier(onMessage);
    } catch (error) {
      const onMessage = "Could not authenticate you. Please try again later";
      showDialogNotifier(onMessage);
    }
    //_globalKey.currentState.reset();
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: _authMode == AuthMode.Signup ? 390 : 300,
        width: deviceSize.width * 0.75,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 390 : 300),
        padding: EdgeInsets.all(16),
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    labelStyle: TextStyle(
                        fontFamily: "Anto", fontWeight: FontWeight.bold),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    user['email'] = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "Invaild email";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_focusPassword);
                  },
                ),
                TextFormField(
                  focusNode: _focusPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.vpn_key),
                    labelStyle: TextStyle(
                        fontFamily: "Anto", fontWeight: FontWeight.bold),
                  ),
                  controller: _controlerPassword,
                  onSaved: (value) {
                    user['password'] = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return "Password is too short";
                    }
                    //return null
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                      obscureText: true,
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        labelText: "Confirm password",
                        prefixIcon: Icon(Icons.vpn_key),
                        labelStyle: TextStyle(
                            fontFamily: "Anto", fontWeight: FontWeight.bold),
                      ),
                      onSaved: (value) {},
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _controlerPassword.text) {
                                return "Password do not match!";
                              }
                              return null;
                            }
                          : null),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    onPressed: _onSumit,
                    elevation: 5,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Colors.blue,
                    child: Text(
                      _authMode == AuthMode.Signup ? "SIGNUP" : "LOGIN",
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                    _authMode == AuthMode.Login ? "SIGNUP" : "LOGIN",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
                //_switchAuthMode,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
