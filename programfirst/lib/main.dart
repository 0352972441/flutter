


import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';
main()=> runApp(new MyApp());


class MyApp extends StatefulWidget{
    @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

  class MyAppState extends State<MyApp>{

    var indexQuestion = 0;
    int _totalScore =0;
    List<Map<String, Object>> question = [
      {"question":"Why don\'t we running sometime ?",
        "answer": 
        [
          {"text":"Good idea", "score": 10},
          {'text':"Not i can\'t",'score':5},
          {'text':"Stupid", 'score': 0}
        ]
      },
      {"question":"What do you favorite  ?",
        "answer": 
        [
          {'text':"Good idea", 'score':10}, {'text':"Not i can\'t",'score':5}, {'text':"Play game", 'score':0}
        ]
      },
      {"question":"Where do you .... ?",
        "answer": [
          {'text':"Live",'score':10},
          {'text':"Life\'t",'score':5},
          {'text':"Like", 'score':0}
          ]
      },
    ];

    void answerQuestion(int score){
      _totalScore += score;
      setState(() {
        indexQuestion = indexQuestion +1;
      });
      
      print(indexQuestion);
    }

    @override
    Widget build(BuildContext context){
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text('My first App'),),
          body: indexQuestion < question.length ? 
          Quiz(indexQuestion: indexQuestion,question: question,answer: answerQuestion,)
          : Result(_totalScore),
        ));
    }
}