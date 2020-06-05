

import 'package:flutter/material.dart';

class Answer extends StatelessWidget{
    final Function selectedAnswer;
    final String answer;
   //var selectedAnswer;
    Answer(this.selectedAnswer, this.answer);
    //Answer(this.selectedAnswer);

    @override
    Widget build(BuildContext build){
      return Container(
        width: double.infinity,
        child: RaisedButton(
          onPressed: selectedAnswer,
          color: Colors.blue,
          child: Text(answer),
          ),
      );
    }
}