
import '../screens/category_meals_screen.dart';
import 'package:flutter/material.dart';
class CategoryItem extends StatelessWidget {
  final Color color;
  final String title;
  final String id;
  CategoryItem(this.color, this.title, this.id);

  @override
  Widget build(BuildContext context) {

     void selectedMeals(BuildContext context){
        Navigator.pushNamed(context, CategoryMealsScreen.routeName ,arguments: {'id':id, 'title':title}
      );
      
    }

    return InkWell(
          onTap: ()=> selectedMeals(context),
          splashColor: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Text(title, style: Theme.of(context).textTheme.title),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color.withOpacity(0.7), color], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20)
            ),
          ),
    );
    
  }
}