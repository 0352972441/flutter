

import 'package:flutter/material.dart';
import 'package:programfirst/answer.dart';
import 'package:programfirst/question.dart';

class Quiz extends StatelessWidget{
  final int indexQuestion;
  final List<Map<String,Object>> question;
  final Function answer;

  Quiz({this.answer, this.indexQuestion, this.question});

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Question(question[indexQuestion]['question']),
        ...(question[indexQuestion]["answer"] as List<Map<String, Object>>).map((value){
            return Answer(()=>answer(value['score']), value['text']);
        }).toList()
      ],
    );
  }
}