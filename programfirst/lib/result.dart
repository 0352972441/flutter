

import 'package:flutter/cupertino.dart';

class Result extends StatelessWidget{
  final int resultScore;
  Result(this.resultScore);

  String get resultPlay{
    String result;
    if(resultScore <= 8){
      result = ' Your are very bad';
    }else if( resultScore <= 16){
      result = 'Your are  normal person!';
    }else if(resultScore <= 25){
      result = ' your are quite very well!';
    }else{
      result = ' Your are very well';
    }
    return result;
    
  }

  @override
  Widget build (BuildContext context){
    return Center(child: Text(resultPlay, style: TextStyle(fontSize: 30) ));
  }
}