import 'package:delimeals/models/meals.dart';
import '../screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final int duration;
  final String imageUrl;
  final Complexity complexity;
  final Affordability affordability;
  final Function remoteIndex;
  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.affordability,
    @required this.complexity,    
    @required this.remoteIndex
  });

  String get complexityText{
    switch(complexity){
      case Complexity.Simple :
        return 'Simple';
      case Complexity.Challenging :
        return 'Challenging';
      case Complexity.Hard :
        return 'Hard';
    }
  }

  String get offordabilityText{
    switch(affordability){
      case Affordability.Affordable :
        return 'Affordable';
      case Affordability.Pricey :
        return 'Pricey';
      case Affordability.Luxurious :
        return 'Luxurious';
    }
  }
  void selectedItem(BuildContext context){
      Navigator.pushNamed(context, MealDetailScreen.NAMEPAGE, arguments: id).then((value)=>{
        if(value != null){
          remoteIndex(value)
        },
      });
    }
 

  @override
  Widget build(BuildContext context) {
    print("Meals Item ");
    return InkWell(
      onTap: ()=> selectedItem(context),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: <Widget>[
              Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(imageUrl,/*fit: BoxFit.cover, height: 250, width: double.infinity,*/)
                ),
                Positioned(
                    bottom: 10,
                    right: 20,
                    width: 300,
                    child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: Colors.black54,
                    child: Text(title, softWrap: true , style: Theme.of(context).textTheme.body2, overflow: TextOverflow.fade,)
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule, color: Colors.orange),
                      SizedBox(width: 10,),
                      Text('$duration min')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work, color: Colors.lightBlueAccent),
                      SizedBox(width: 10,),
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.monetization_on, color: Colors.yellow,),
                      SizedBox(width: 10,),
                      Text(offordabilityText)
                    ],
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}