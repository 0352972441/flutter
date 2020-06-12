import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/new_transaction.dart';
import 'package:flutter_complete_guide/Widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  
  Widget build(BuildContext context){
    
    return MaterialApp(
      title:('Expenditure management'),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.blue,
        errorColor: Colors.red,
        fontFamily: "OpenSans",
        textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'Opensans',fontSize: 18, fontWeight: FontWeight.bold),
            button: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'Opensans',fontSize: 20, fontWeight: FontWeight.bold),
          )
        )
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionState();
  }
}

class TransactionState extends State<MyHomePage>{
  
  // String titleInput;
  // String amountInput;

   final List<Transaction> _transaction = [
      // Transaction(id: "01", title: "Ball", amount: 99.99, date: DateTime.now()),
      // Transaction(id: "02", title: "Shore", amount: 32.19, date: DateTime.now()),
    ];

    List<Transaction> get createCharTransacion{
      return _transaction.where((element){
          return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
    }


  void addTransaction(String title , double amount, DateTime chosenDate){
    Transaction newTransaction = new Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: chosenDate);
    setState(() {
      _transaction.add(newTransaction);
    });
  }
 /*
  void remoteTransaction(int index){
    setState(() {
      _transaction.removeAt(index);
    });
  }*/
 
  void remoteTransaction(String id){
    /// [removeWhere]  object equal ID 
    setState(() {
      _transaction.removeWhere((value)=> value.id == id);
    });
  }

  void addTransactionDialog(BuildContext context){
    showModalBottomSheet(context: context,
     builder: (_)=> GestureDetector(
       onTap: ()=>{},
       child: NewStransaction(addTransaction),
       behavior: HitTestBehavior.opaque,
     )
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Expenditure management "),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add, color: Colors.white), onPressed: ()=>addTransactionDialog(context))
          ],
        ),
        body: SingleChildScrollView(
            child:Column(
          // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(createCharTransacion),
              TransactionList(_transaction, remoteTransaction),
            ],
          ), 
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: ()=>addTransactionDialog(context),
          ),
      );
  }
}
