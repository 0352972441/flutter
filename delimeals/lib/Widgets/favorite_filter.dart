import 'package:delimeals/Widgets/widget_draw.dart';
import 'package:flutter/material.dart';

class FavoriteFilter extends StatefulWidget {
  static const String ROUTENAME = '/filter';
  final stateCurrent;
  final Function saveFilter;

  FavoriteFilter(this.stateCurrent, this.saveFilter);

  @override
  _FavoriteFilterState createState() => _FavoriteFilterState();
}

class _FavoriteFilterState extends State<FavoriteFilter> {
  bool glutenfree = false;
  bool lactoseFree = false;
  bool vegetarian = false;
  bool vegan = false;

  @override
  initState(){
    glutenfree = widget.stateCurrent['gluten'];
    lactoseFree = widget.stateCurrent['lactose'];
    vegetarian = widget.stateCurrent['vegetarian'];
    vegan = widget.stateCurrent['vegan'];
    super.initState();
  }

   _buildSwitchListTile(String title , String subtitle, Function updateState, bool currenState){
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currenState,
      onChanged: updateState
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.save, color: Colors.white,), 
        onPressed: (){
            final stateCurrent = {
              'gluten': glutenfree,
              'lactose': lactoseFree,
              'vegan': vegan,
              'vegetarian': vegetarian,
            };
            widget.saveFilter(stateCurrent);
          }
        )
      ],),
      drawer: WidgetDraw(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text("Ajust your meals selected", style: Theme.of(context).textTheme.title,),
          ),
          Expanded( 
            child: ListView(
              children: <Widget>[
                  _buildSwitchListTile("Lactose Free", "Only include lactose free meals", (value){
                    setState(() {
                      lactoseFree = value;
                    });
                  }, lactoseFree),

                  _buildSwitchListTile("Vegan ", "Only include vegan meals", (value){
                    setState(() {
                      vegan = value;
                    });
                  }, vegan),

                  _buildSwitchListTile("vegetarian", "Only include vegetarian meals", (value){
                    setState(() {
                      vegetarian = value;
                    });
                  }, vegetarian),

                  _buildSwitchListTile("Gluten Free", "Only include gluten free meals", (value){
                    setState(() {
                      glutenfree = value;
                    });
                  }, glutenfree),
              ],
            ),
          )
        ],
      ) 
    );
  }
}