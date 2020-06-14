
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/new_transaction.dart';
import 'package:flutter_complete_guide/Widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
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

    bool _showChart = false;

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

  void _addTransactionDialog(BuildContext context){
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
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS? CupertinoNavigationBar(
      middle: Text('Expenditure management'),
      trailing: Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: ()=> _addTransactionDialog(context),
          )
        ],
      ),
    ) :AppBar(title: Text("Expenditure management "),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add, color: Colors.white), onPressed: ()=>_addTransactionDialog(context))
          ],
        );
    
    final bodyPages = SafeArea(child: SingleChildScrollView(
            child:Column(
          // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if(isLandscape)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart' ,style: Theme.of(context).textTheme.title,),
                  Switch.adaptive(value: _showChart, onChanged: (value){
                    setState(() {
                      _showChart = value;
                    });
                  }),
                ],
              ),
              if(!isLandscape)
                Container(
                  height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3 , 
                  child: Chart(createCharTransacion),
                ),
              if(!isLandscape)
                Container(
                height: (mediaQuery.size.height * 0.7 - appBar.preferredSize.height),
                child: TransactionList(_transaction, remoteTransaction),
              ),

              if(isLandscape)
              _showChart ? Container(
                  height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.6 , 
                  child: Chart(createCharTransacion),
                ):
              Container(
                height: (mediaQuery.size.height * 0.7 - appBar.preferredSize.height),
                child: TransactionList(_transaction, remoteTransaction),
              )
            ],
          ), 
        )
    );

      return Platform.isIOS ? CupertinoPageScaffold(child: bodyPages, navigationBar: appBar,) :Scaffold(
        appBar: appBar,
        body: bodyPages,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
          tooltip: 'Add Transaction',
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: ()=>_addTransactionDialog(context),
          ),
      );
  }
}
