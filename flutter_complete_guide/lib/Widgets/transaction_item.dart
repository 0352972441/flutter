import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionItem extends StatefulWidget {
  const TransactionItem({
      Key key,
      @required this.transaction,
      @required Function remoteTransaction,
    }) : remoteTransaction = remoteTransaction, super(key: key);

    final Transaction transaction;
    final Function remoteTransaction;
    @override
  State<StatefulWidget> createState() {
    print("StateFul");
    return new TransactionItemState();
  }
  }
  class TransactionItemState extends State<TransactionItem>{
  Color btColor;
  final RandomColors = [Colors.black, Colors.yellow, Colors.green, Colors.pink];
  @override
  void initState() {
    //final RandomColors = [Colors.black, Colors.yellow, Colors.green, Colors.pink];
    //btColor = RandomColors[Random().nextInt(4)];
      print("initState:");
      btColor = RandomColors[Random().nextInt(4)];
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
       child: Padding(
         padding: EdgeInsets.all(5),
         child: ListTile(
           leading: CircleAvatar(
             backgroundColor: btColor,
             radius: 30, 
             child: FittedBox(
               child: Text('\$${widget.transaction.amount}', style: TextStyle(fontWeight: FontWeight.bold),),
               )
             ),
           title: Text(widget.transaction.title, style: Theme.of(context).textTheme.title ),
           subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
           trailing: MediaQuery.of(context).size.width > 500 ? 
            FlatButton.icon(
              onPressed: ()=> widget.remoteTransaction(widget.transaction.id), icon: Icon(Icons.delete, color: Colors.red,), label: Text('Delete')
              ):IconButton(icon: Icon(Icons.delete, 
               color: Theme.of(context).errorColor,
                ),
                onPressed: ()=>widget.remoteTransaction(widget.transaction.id),
             ),
         ),
       ),
     );
  }
}