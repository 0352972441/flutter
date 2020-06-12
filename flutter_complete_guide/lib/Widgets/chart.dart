

import 'package:flutter/material.dart';
import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class Chart extends StatelessWidget {
  final List<Transaction> listTrasaction;
  Chart(this.listTrasaction);

  List<Map<String, Object>> get createCharTransacion{
    return List.generate(7, (index){
        var totalSum = 0.0;
        final weekend = DateTime.now().subtract(Duration(days: index));
        listTrasaction.forEach((value) {
          if(value.date.day == weekend.day && value.date.month == weekend.month && value.date.year == weekend.year){
            totalSum += value.amount;
          }
        });
        return {'day':DateFormat.E().format(weekend), 'amount':totalSum};
    }).reversed.toList();
  } 

  double get spendingTotalAmount{
        return createCharTransacion.fold(0.0, (sum, value){
          return sum + value['amount'];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
        child: Container(
         margin: EdgeInsets.all(10),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: createCharTransacion.map((data){             
              return Flexible(
                fit: FlexFit.tight,
                //flex: 2,
                child: CharBar(data['day'], data['amount'], data['amount'] == 0.0 ? 0.0: (data['amount'] as double)/ spendingTotalAmount ),
              );
          }).toList()         
        ),
        )
    );
  }
}