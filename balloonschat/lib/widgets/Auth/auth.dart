import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  Auth(this._sumitRegister, this._isLoading);
  final void Function(String email, String userName, String password,
      bool isLogin, BuildContext context) _sumitRegister;
  final bool _isLoading;
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _globalKey = GlobalKey<FormState>();
  bool _isLogin = true;
  final Map<String, Object> user = {
    'email': "",
    'userName': "",
    'password': ""
  };

  void _submitSaveForm() {
    final isValid = _globalKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _globalKey.currentState.save();
    print(user['email']);
    print(user['userName']);
    print(user['password']);
    FocusScope.of(context).unfocus();
    widget._sumitRegister(
        user['email'], user['userName'], user['password'], _isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          key: ValueKey("email"),
                          validator: (value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              InputDecoration(labelText: "Email address"),
                          onSaved: (value) {
                            user['email'] = value;
                          },
                        ),
                        if (!_isLogin)
                          TextFormField(
                            key: ValueKey('userName'),
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length < 6 && value.length > 15) {
                                return "Please enter least at 6 character";
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "User name"),
                            onSaved: (value) {
                              user['userName'] = value;
                            },
                          ),
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return "Please enter least at 6 character";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Password"),
                          obscureText: true,
                          onSaved: (value) {
                            user['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (widget._isLoading) CircularProgressIndicator(),
                        if (!widget._isLoading)
                          RaisedButton(
                            onPressed: _submitSaveForm,
                            color: Colors.blue,
                            child: Text(_isLogin ? "Login" : "Signup"),
                          ),
                        if (!widget._isLoading)
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? "I don't have account"
                                  : "I already have account"))
                      ],
                    )),
              ),
            ),
          )),
    );
  }
}
