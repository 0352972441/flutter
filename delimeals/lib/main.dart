import 'dart:ui';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import 'package:flutter/material.dart';

main()=> runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.blue,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(color: Color.fromRGBO(225, 224, 229, 1)),
          body2: TextStyle(color: Colors.cyan, fontSize: 26, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
          title: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 20, fontWeight: FontWeight.bold)
        )
      ),
      //home: CategoryScreen(),
      initialRoute: '/', //default is '/'
      routes: {
        '/': (context)=> CategoryScreen(),
        CategoryMealsScreen.routeName: (context)=> CategoryMealsScreen(),
      },
    );
  }
}

