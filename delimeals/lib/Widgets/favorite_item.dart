import 'package:delimeals/screens/meal_detail_screen.dart';
import 'package:flutter/material.dart';


class FavoriteItem extends StatelessWidget {
  final String title;
  final String id;
  final Color color;
  final String urlImage;
  FavoriteItem(this.title, this.id, this.color, this.urlImage);

  void _selectedItem(BuildContext context){
    Navigator.pushNamed(context, MealDetailScreen.NAMEPAGE, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> _selectedItem(context),
      splashColor: Colors.red,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(urlImage), fit: BoxFit.cover),
          gradient: LinearGradient(colors: [color.withOpacity(0.6), color, Colors.lightBlueAccent]),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child:Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepPurple, fontFamily: 'RobotoCondensed')),
      ),
    );
  }
}