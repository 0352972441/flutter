import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdapterFlatButton extends StatelessWidget {
  @override
  final Function _showDatePicker;
  final String text;

  AdapterFlatButton(this._showDatePicker, this.text);

  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoButton(
      child: Text(
        text, style: Theme.of(context).textTheme.button,
      ), 
      onPressed: _showDatePicker
      ) : FlatButton(onPressed: _showDatePicker, child: Text(
                    text ,style: Theme.of(context).textTheme.button,
                  ),
                  textColor: Theme.of(context).textTheme.button.color,
                  //color: Theme.of(context).primaryColor,
                  );
  }
}