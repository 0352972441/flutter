import 'package:flutter/material.dart';
import '../screens/order_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(
        children: <Widget>[
          AppBar(
              title: Text(
            'Shopping Now !',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                fontSize: 20),
          )),
          ClipPath(
            clipper: buildClip(),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue.withOpacity(0.5),
                  Colors.blue,
                  Colors.blue.withOpacity(0.2),
                ], begin: Alignment.topLeft, end: Alignment.centerRight),
                // buildClip()
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/icon.jpg'),
                  )
                ],
              ),
            ),
          ),
          // Divider(
          //   height: 5,
          //   color: Colors.deepOrangeAccent,
          // ),
          SizedBox(
            height: 20,
          ),
          buildListTile(Icons.shop, "Shopping", context, () {
            Navigator.pushReplacementNamed(context, '/');
          }),
          buildListTile(
              Icons.shopping_cart,
              'Order',
              context,
              () => {
                    Navigator.pushReplacementNamed(
                        context, OrderScreen.ROUTENAME)
                  }),
          buildListTile(Icons.account_circle, 'Information', context, () {}),
        ],
      )),
    );
  }

  ListTile buildListTile(IconData icon, String title, BuildContext context,
      Function selectedItem) {
    return ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
          size: 30,
        ),
        title: Title(
          color: Colors.black,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                //fontFamily: 'Lato',
                color: Colors.pink,
                fontSize: 18),
          ),
        ),
        onTap: selectedItem);
  }
}

class buildClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldRe(Size size) {
    return false;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
    throw UnimplementedError();
  }
}