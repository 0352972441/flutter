import 'dart:ui';
import 'package:delimeals/models/dummy_data.dart';

import './Widgets/favorite_filter.dart';
import './screens/tabs_screen.dart';

import './screens/meal_detail_screen.dart';
import './screens/meal_detail_screen.dart';
import './models/meals.dart';
import './screens/category_meals_screen.dart';
import 'package:flutter/material.dart';

main()=> runApp(MyApp());


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _mealsAvaiable = DUMMY_MEALS;
  List<Meal> _mealFavorite = [];

  void _setFilter(Map<String, bool> stateFilter){
    setState(() {
      _filter = stateFilter;

      _mealsAvaiable = DUMMY_MEALS.where((element){
        if(_filter['gluten'] && element.isGlutenFree){
          return true;
        }
        
        if(_filter['lactose'] && element.isLactoseFree){
          return true;
        }

        if(_filter['vegetarian'] && element.isVegetarian){
          return true;
        }

        if(_filter['vegan'] && element.isVegan){
          return true;
        }
        return false;
      }).toList();

    });
  }

  void _getListFavorite(String id){
    final int favoriteIndex = _mealFavorite.indexWhere((element) => element.id == id);// -1 là không tìm thấy
    if(favoriteIndex >= 0){// Nếu mà tìm thấy trong danh sách favorite
      setState(() {
        _mealFavorite.removeWhere((element) => element.id == id);
      });
    }else{// Nếu không thấy thì add và danh sách Favortite
      setState(() {
        _mealFavorite.add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      });
    }
  }

  bool checkFavorite(String id){
      return _mealFavorite.any((element) => element.id == id);
  }

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
        '/': (context)=> TabsScreen(_mealFavorite), 
        CategoryMealsScreen.routeName: (context)=> CategoryMealsScreen(_mealsAvaiable),
        MealDetailScreen.NAMEPAGE : (context)=> MealDetailScreen(_getListFavorite, checkFavorite),
        FavoriteFilter.ROUTENAME : (context)=> FavoriteFilter(_filter,_setFilter),
      },
      // onGenerateRoute: (settings){
      //   return MaterialPageRoute(builder: (context)=> CategoryMealsScreen());
      // },
    );
  }
}

