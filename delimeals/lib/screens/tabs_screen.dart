import 'package:delimeals/Widgets/widget_draw.dart';
import 'package:delimeals/screens/categories_screen.dart';
import '../screens/Favorite_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  final mealFavorite;

  TabsScreen(this.mealFavorite);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _listSelectedPage;
  final List<Map<String, Object>> bottomNavigationBarItem = [
      {'title':'Category', 'icon':Icons.category},
      {'title':'Your Favotite', 'icon': Icons.star}
    ];
  @override
  initState(){
    _listSelectedPage = [
      {'page': CategoryScreen(), 'title': 'Category'},
      {'page': FavoriteScreen(widget.mealFavorite), 'title': 'Your Favorite'}
    ];
  }

  int indexSelectedPage = 0;
  void selectedPage(int index){
      setState(() {
        indexSelectedPage = index;
      });
    }

    

  @override
  Widget build(BuildContext context) {
    print("Tab Screen!");
    return Scaffold(
      appBar: AppBar(title: Text(_listSelectedPage[indexSelectedPage]['title']),),
      drawer: WidgetDraw(),
      body: _listSelectedPage[indexSelectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow,
        selectedFontSize: 14,
        onTap: selectedPage,
        currentIndex: indexSelectedPage,
        items: bottomNavigationBarItem.map((value){
          return BottomNavigationBarItem(
            icon: Icon(value['icon']),
            title: Text(value['title'])
          );
        }).toList()
      ),
    );
  }
}

/*DefaultTabController(
      length: 2,
      initialIndex: 0, 
      child: Scaffold(
        appBar: AppBar(title: Text("Meals"), bottom: TabBar(tabs: <Widget>[
          Tab(icon: Icon(Icons.category), text: "Meals",),
          Tab(icon: Icon(Icons.star), text: "Favorite",)
        ],),),
        body: TabBarView(
          children: <Widget>[
            CategoryScreen(), 
            FavoriteScreen(),
          ],  
        ),
      ),
    ); */