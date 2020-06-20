

import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard
}

enum Affordability{
  Affordable,
  Pricey,
  Luxurious
}

class Meal{
  final String id;
  final String title;
  final String imageUrl;
  final List<String> categories;
  final List<String> steps;
  final List<String> ingredients;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  final bool isGlutenFree;
  
  const Meal(
    {
      @required this.id, 
      @required this.categories,
      @required this.title, 
      this.affordability,
      this.complexity,
      this.imageUrl,
      this.duration,
      this.ingredients, 
      this.steps, 
      this.isGlutenFree,
      this.isVegan,
      this.isVegetarian,
      this.isLactoseFree,
      
    });

}

