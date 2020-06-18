import 'package:flutter/material.dart';
import '../Widgets/chart.dart';



class DirectionWidget extends StatelessWidget {
  final MediaQueryData mediaQuery;
  final AppBar appBar;String name;
  final List createCharTransacion;
  Widget listWidget;
  DirectionWidget(this.appBar, this.createCharTransacion, this.mediaQuery, this.listWidget);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        Container(
          height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3 , 
          child: Chart(createCharTransacion),
        ),
        listWidget
      ],
    );
  }
}