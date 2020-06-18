
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import '../Widgets/transaction_item.dart';

class TransactionList extends StatelessWidget{
    final List<Transaction> transaction;
    final Function _remoteTransaction;
    TransactionList(this.transaction, this._remoteTransaction);
    @override
    Widget build(BuildContext context){
        return Container(
            //child:ListView(
              child: transaction.isEmpty ? LayoutBuilder(builder: (context, contraints){
                return Column(
                children: <Widget>[
                  Text('Not transaction add yet!', style: Theme.of(context).textTheme.title),
                  SizedBox(
                    height: contraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: contraints.maxHeight * 0.7,
                    child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),
                  )
                ]
                );
              })
              :ListView(children:transaction.map((value){
                  return TransactionItem(key: ValueKey(value.id), transaction: value, remoteTransaction: _remoteTransaction);
              }).toList() 
              /*ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (context, index){
                  print("Value: ${index}");
                  return TransactionItem(key: ValueKey(transaction[index].id), transaction: transaction[index], remoteTransaction: _remoteTransaction);
                }
                
                )*/)
          );
      
    }
}

