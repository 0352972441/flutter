import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
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
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email address"),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "userName"),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.blue,
                      child: Text("Login"),
                    ),
                    FlatButton(onPressed: () {}, child: Text("Signup"))
                  ],
                )),
              ),
            ),
          )),
    );
  }
}
