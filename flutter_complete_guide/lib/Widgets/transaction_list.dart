
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

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
              :ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (context, index){
                   return Card(
                     elevation: 5,
                     margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30, 
                            child: FittedBox(
                              child: Text('\$${transaction[index].amount}', style: TextStyle(fontWeight: FontWeight.bold),),
                              )
                            ),
                          title: Text(transaction[index].title, style: Theme.of(context).textTheme.title ),
                          subtitle: Text(DateFormat.yMMMd().format(transaction[index].date)),
                          trailing: MediaQuery.of(context).size.width > 500 ? 
                           FlatButton.icon(
                             onPressed: ()=> _remoteTransaction(transaction[index].id), icon: Icon(Icons.delete, color: Colors.red,), label: Text('Delete')
                             ):IconButton(icon: Icon(Icons.delete, 
                              color: Theme.of(context).errorColor,
                               ),
                               onPressed: ()=>_remoteTransaction(transaction[index].id),
                            ),
                        ),
                      ),
                    );
                },
            ),
          );
      
    }
}