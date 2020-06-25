import 'package:delimeals/Widgets/category_item.dart';

import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   

    return  Scaffold(
        //appBar: AppBar(title: const Text('Delimeals'),),
        body: GridView(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3/2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
            ),
            children: DUMMY_CATEGORIES.map((value)=> CategoryItem(value.color, value.title, value.id)).toList(),
          ),
    );     
  }
}