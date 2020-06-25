



import 'package:delimeals/Widgets/favorite_filter.dart';
import 'package:flutter/material.dart';

class WidgetDraw extends StatelessWidget {

 Widget buildListTile(String title, IconData icon, Function onTapHander){
      return ListTile(
        leading: Icon(icon, size:30,),
        title: Text(title, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),),
        onTap: onTapHander
      );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //   //color: Colors.amberAccent,
            //   border: Border.all(width: 2, color: Colors.green),
            // ),
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up !',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36, color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(height: 50,),
          buildListTile("Meals", Icons.restaurant, ()=>{
            //Navigator.pushNamed(context, "/")
            Navigator.pushReplacementNamed(context, '/')
          }),
          buildListTile("Settings", Icons.settings, (){
            //Navigator.pushNamed(context, FavoriteFilter.ROUTENAME);
            Navigator.pushReplacementNamed(context, FavoriteFilter.ROUTENAME);
          })
        ],
      ),
    );
  }
}