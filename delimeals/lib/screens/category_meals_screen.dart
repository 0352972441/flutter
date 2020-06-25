import 'package:delimeals/Widgets/meal_item.dart';
import '../models/dummy_data.dart';
import '../models/meals.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/categories-meals'; 

  @override
  _CategoryMealsScreenState createState(){
    print("Create Again!");
    return _CategoryMealsScreenState();
  } 
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
    String title;
    List<Meal> categoryMeals;
    bool check = false;
   
    

    @override
  void initState() {
    
    super.initState();
  }

    @override
    void didChangeDependencies() {
    
      if(!check){
        final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      title = routeArgs['title'];
      final String id = routeArgs['id'];
      categoryMeals = DUMMY_MEALS.where((value){
            return value.categories.contains(id);
        }).toList();
        check = true;
      }
    super.didChangeDependencies();
  }

    void _remoteIndex(String id){
      setState(() {
        categoryMeals.removeWhere((element) => element.id == id);
      });
    }
      
    
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: ListView.builder(itemBuilder: (context, index){
        return MealItem(title: categoryMeals[index].title, imageUrl: categoryMeals[index].imageUrl, duration: categoryMeals[index].duration, affordability: categoryMeals[index].affordability, complexity: categoryMeals[index].complexity, id: categoryMeals[index].id, remoteIndex: _remoteIndex,);
      },itemCount: categoryMeals.length,),
    );
  }
}