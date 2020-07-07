
import 'dart:math';

import 'package:delimeals/Widgets/favorite_item.dart';
import 'package:delimeals/Widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../models/meals.dart';
class FavoriteScreen extends StatelessWidget {
  final List<Meal> _mealFavorite;
  FavoriteScreen(this._mealFavorite);

  final List<Color> colors = [
    Colors.black, Colors.blueAccent, Colors.yellow, Colors.green, Colors.pink, Colors.purple
  ];

  Color get radomColors{
    int index =  Random().nextInt(colors.length);
    return colors[index];
  }
  
  @override
  Widget build(BuildContext context) {
    print(" favorite Screen");
    return _mealFavorite.length==0 ? Center(
      child: Text("Not Add Favorite yet ! "),
    ) :
    /*GridView.builder( 
       itemCount: _mealFavorite.length,
       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
       gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
       ),
       itemBuilder: (context, index){
         return FavoriteItem(_mealFavorite[index].title, _mealFavorite[index].id, radomColors, _mealFavorite[index].imageUrl);
       } 
    ,);*/
    ListView.builder(itemBuilder: (context, index) {
      Meal meal = _mealFavorite[index];
      return MealItem(id: meal.id, title: meal.title, imageUrl: meal.imageUrl, duration: meal.duration, affordability: meal.affordability, complexity: meal.complexity);
    },
    itemCount: _mealFavorite.length,);
  }
}