import 'package:flutter/material.dart';
import '../screens/homepage.dart';

class FormLogin extends StatefulWidget {
  final Size mediaQuery;
  FormLogin(this.mediaQuery);
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final focusPassword = FocusNode();
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _globalKey,
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: <Widget>[
                TextFormField(
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(focusPassword),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      hintText: "Tên đăng nhập",
                      //icon: Icon(Icons.account_circle),
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.green,
                      ),

                      //ClipOval(
                      //   child: Image.asset(
                      //     "assets/images/user.png",
                      //     height: 10,
                      //     width: 10,
                      //     //fit: BoxFit.fill,
                      //   ),
                      // ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                              style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                              style: BorderStyle.solid))),
                ),
                SizedBox(height: widget.mediaQuery.height * 0.02),
                TextFormField(
                  focusNode: focusPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      hintText: "Mật khẩu",
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.green,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 2,
                            color: Colors.grey,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                              style: BorderStyle.solid))),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: widget.mediaQuery.height * 0.02),
        Container(
          height: widget.mediaQuery.height * 0.06,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 30, right: 30),
          // padding: EdgeInsets.only(left: 30, right: 30),
          // width: double.infinity,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30),
          //     color: Colors.green),
          child: RaisedButton(
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ));
            },
            child: Text(
              "Đăng nhập",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            splashColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        )
      ],
    );
  }
}
