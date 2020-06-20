import 'package:delimeals/Widgets/meal_item.dart';

import '../models/meals.dart';
import '../models/dummy_data.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const String routeName = '/categories-meals'; 
  // final String title;
  // final String id;
  // CategoryMealsScreen(this.title, this.id);
  
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String title = routeArgs['title'];
    final String id = routeArgs['id'];

    final categoryMeals = DUMMY_MEALS.where((value){
          return value.categories.contains(id);
      }).toList();
    

    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: ListView.builder(itemBuilder: (context, index){
        return MealItem(title: categoryMeals[index].title, imageUrl: categoryMeals[index].imageUrl, duration: categoryMeals[index].duration, affordability: categoryMeals[index].affordability, complexity: categoryMeals[index].complexity);
      },itemCount: categoryMeals.length,)
    );
  }
}