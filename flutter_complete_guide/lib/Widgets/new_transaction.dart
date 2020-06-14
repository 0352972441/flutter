import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime _timerPicker;
  final Function _addTransaction;
/// newTransaction is widgetlessState
/// [NewTransaction]Create Data for card input title and amount
/// Method get one method sync Function 
  NewStransactionState(this._addTransaction);

  void onSumitData(){
    if(_amountControler.text.isEmpty){
      return;
    }
    final enterText = _titleControler.text;
    final enterAmount = double.parse(_amountControler.text);
    if(enterAmount <= 0 || enterText.isEmpty || _timerPicker == null){
      return;
    }
    _addTransaction(
      enterText, enterAmount, _timerPicker
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker(){
    showDatePicker(
      context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()
    ).then((DateTime datePicker){
        if(datePicker == null){
          return;
        }
        setState(() {
           _timerPicker = datePicker;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: AssetImage('assets/images/background.jpg'),
          //   fit: BoxFit.cover)
          // ),
          color: Colors.lightBlue[50],
          padding: EdgeInsets.only(top: 10, left: 10, right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 16),
                  labelText: 'Name',fillColor: Colors.red
                ),
                controller: _titleControler,
                onSubmitted: (_)=> onSumitData(),
                //onChanged: (value) => titleInput = value
              ),
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 16),
                  labelText: 'Amount',
                ),
                controller: _amountControler,
                onSubmitted: (_)=> onSumitData(),
                //onChanged: (value) => amountInput = value
              ),

              Row(
                children: <Widget>[
                  SizedBox(height: 70,),
                  Expanded(
                    child: Text( 
                        _timerPicker == null ? 'Not choose data': 'Picker Date: ${DateFormat.yMMMd().format(_timerPicker)}', style: TextStyle(fontWeight: FontWeight.bold),
                       ),
                      ),
                  FlatButton(onPressed: _showDatePicker, child: Text(
                    'Choose date',style: Theme.of(context).textTheme.button,
                  ),
                  textColor: Theme.of(context).textTheme.button.color,
                  //color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}