import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/homepage.dart';
import 'package:login/widgets/form_login.dart';
import '../widgets/button_other_login_widget.dart';

class HomeLogin extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: mediaQuery.height * 0.06, right: 5, left: 5, bottom: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    child: Image.asset(
                      "assets/images/ic_logo_login_waka.jpg",
                      height: 140,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Text(
                  //   "Waka 4.0",
                  //   style: TextStyle(
                  //       color: Colors.blue,
                  //       fontStyle: FontStyle.normal,
                  //       fontWeight: FontWeight.w900,
                  //       fontSize: 40),
                  // ),
                ],
              ),
              SizedBox(height: mediaQuery.height * 0.05),
              // Form
              FormLogin(mediaQuery),
              SizedBox(
                height: 18,
              ),
              Padding(
                ///padding: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {},
                            child: Text('Đăng ký ngay',
                                style: Theme.of(context).textTheme.title),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {},
                            child: Text('Quên mật khẩu ?',
                                style: Theme.of(context).textTheme.title),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      buildExpanded(Colors.green, 1, 2, 30, 5),
                      Text('Hoặc'),
                      buildExpanded(Colors.green, 1, 2, 5, 30)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ButtonOtherLoginWidget(
                            "assets/images/bg_login_facebook.png",
                            () => _key.currentState.showSnackBar(
                                SnackBar(content: Text("On Click")))),
                        ButtonOtherLoginWidget(
                            "assets/images/bg_login_google.png", null),
                        ButtonOtherLoginWidget(
                            "assets/images/bg_login_facebook.png", null),
                        //buildLogin()
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpanded(Color color, double hight, double thickness,
      double marginLeft, double marginRight) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: marginRight, left: marginLeft),
        child: Divider(
          color: color,
          height: hight,
          thickness: thickness,
        ),
      ),
    );
  }

  /*Widget buildLogin() {
    return InkWell(
        onTap: () {},
        child: ClipOval(
          child: Image.asset(
            "assets/images/bg_login_facebook.png",
            height: 75,
            width: 75,
          ),
        ));
  }*/
}
