import 'package:flutter/material.dart';
//

class NewStransaction extends StatefulWidget{
  final Function _addTransaction;
    NewStransaction(this._addTransaction);
  @override
  State<StatefulWidget> createState() {
    return new NewStransactionState(_addTransaction);
   
  }
}

class NewStransactionState extends State<NewStransaction> {
  final titleControler = TextEditingController();
  final amountControler = TextEditingController();
  final Function _addTransaction;
/// newTransaction is widgetlessState
/// [NewTransaction]Create Data for card input title and amount
/// Method get one method sync Function 
  NewStransactionState(this._addTransaction);

  void onSumitData(){
    final enterText = titleControler.text;
    final enterAmount = double.parse(amountControler.text);

    if(enterAmount <= 0 || enterText.isEmpty){
      return;
    }
    _addTransaction(
      enterText, enterAmount
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: AssetImage('assets/images/background.jpg'),
          //   fit: BoxFit.cover)
          // ),
          color: Colors.lightBlue[50],
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 16),
                  labelText: 'Name',fillColor: Colors.red
                ),
                controller: titleControler,
                onSubmitted: (_)=> onSumitData(),
                //onChanged: (value) => titleInput = value
              ),
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 16),
                  labelText: 'Amount',
                ),
                controller: amountControler,
                onSubmitted: (_)=> onSumitData(),
                //onChanged: (value) => amountInput = value
              ),

              Row(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Text('Not choose data'),
                  FlatButton(onPressed: null, child: Text(
                    'Choose date',style: Theme.of(context).textTheme.button,
                  ),
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Theme.of(context).primaryColor,
                  )
                ],
              ),

              RaisedButton(
                child: Text('add Transaction',),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                //child: Text('Add transaction',style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                //onPressed: () => {print(titleInput),print(amountInput)},
                //onPressed: ()=> _addTransaction(titleControler.text, double.parse(amountControler.text)),
                onPressed: onSumitData,
              ),
            ],
          ),
        ),
      );
  }
}