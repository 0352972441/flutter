
/*import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/new_transaction.dart';
import 'package:flutter_complete_guide/Widgets/transaction_list.dart';
import '../models/transaction.dart';
class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}


class _UserTransactionState extends State<UserTransaction> {
   final List<Transaction> _transaction = [
      Transaction(id: "01", title: "Ball", amount: 99.99, date: DateTime.now()),
      Transaction(id: "02", title: "Shore", amount: 32.19, date: DateTime.now()),
    ];

  void addTransaction(String title , double amount){
    Transaction newTransaction = new Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now());
    setState(() {
      _transaction.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new NewStransaction(addTransaction),
        new TransactionList(_transaction),
      ],
    );
  }
}*/