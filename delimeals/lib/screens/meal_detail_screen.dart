import 'package:delimeals/models/dummy_data.dart';
import'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {

  final Function mealFavorite;
  final Function checkFavorite;
  MealDetailScreen(this.mealFavorite, this.checkFavorite);

  static const String NAMEPAGE = '/detail-meals';
  
  Widget widgetTitle(BuildContext context, String title){
      return Container(
        child: Padding(
          padding: EdgeInsets.all(5), 
          child: Text(title, style: Theme.of(context).textTheme.title),
        ),
      );
  }

  Widget buildContext(Widget child, double heightContainer){
     return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueGrey)
            ),
            height: heightContainer,
            child: child
     );
  }


  @override
  Widget build(BuildContext context) {
    final idAgrs = ModalRoute.of(context).settings.arguments as String;
    final selectedMeals = DUMMY_MEALS.firstWhere((value)=> value.id == idAgrs);
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeals.title),),
      body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            Container(
              child: Image.network(selectedMeals.imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
            ),
            widgetTitle(context, 'Ingredents'),
            buildContext(ListView.builder(
                itemCount: selectedMeals.ingredients.length,
                itemBuilder: (context , index){
                  return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      color: Theme.of(context).accentColor,
                      child: Padding( padding: EdgeInsets.all(5),child: Text(selectedMeals.ingredients[index], style: Theme.of(context).textTheme.title,)),
                    );
                },
              ),120,
            ),
            widgetTitle(context, 'Step'),
            buildContext(ListView.builder(
              itemBuilder: (context, index){
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: FittedBox(
                          child: CircleAvatar(
                          child: Text('# ${index +1}'),
                        ),
                      ),
                      title: Text(selectedMeals.steps[index], style: TextStyle(fontSize: 25),),
                    ),
                    Divider()
                  ],
                );
              },
              itemCount: selectedMeals.steps.length,
              ),150,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      child: checkFavorite(idAgrs) ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border),
      onPressed: ()=> mealFavorite(idAgrs),
    ),
    );
  }
}