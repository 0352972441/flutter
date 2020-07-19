import 'package:flutter/material.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/auth_screen.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/screens/manage_products_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';
import './providers/carts.dart';
import './providers/order.dart';
import './screens/order_screen.dart';
import './providers/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Main");
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
              update: (context, Auth auth, Products previousProducts) {
                return Products(auth.token);
              },
              create: (ctx) {}
              //create: (ctx) => Products(),
              ),
          ChangeNotifierProvider(
            create: (ctx) => Carts(),
          ),
          ChangeNotifierProxyProvider<Auth, Order>(
            update: (context, auth, previousOrder) => Order(
                auth.token, previousOrder == null ? [] : previousOrder.order),
            create: (BuildContext context) {},
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, value, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Anton',
                      color: Colors.white)),
            ),
            home: value.isAuth()
                ? ProductOverviewScreen()
                : AuthScreen(), //ProductOverviewScreen()
            //initialRoute: '/',
            routes: {
              //'/': (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.ROUTENAME: (context) => ProductDetailScreen(),
              CartScreen.ROUTERNAME: (context) => CartScreen(),
              OrderScreen.ROUTENAME: (context) => OrderScreen(),
              ManageProductsScreen.routeName: (context) =>
                  ManageProductsScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
            },
          ),
        ));
  }
}
