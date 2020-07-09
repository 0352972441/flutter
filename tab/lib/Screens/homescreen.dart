import 'package:flutter/material.dart';
import 'package:tab/Screens/myfavorite.dart';
import 'package:tab/Screens/myhome.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, Object> pages = {
      'home': MyHomePage(),
      'favorite': MyFavorite()
    };

    return DefaultTabController(
        length: pages.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("App demo"),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.favorite),
              )
            ]),
          ),
          body: TabBarView(children: [MyHomePage(), MyFavorite()]),
        ));
  }
}
