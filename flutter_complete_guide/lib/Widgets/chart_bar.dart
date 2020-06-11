
import 'package:flutter/material.dart';

class CharBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double amount;

  CharBar(this.label, this.amount, this.spendingAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          FittedBox(
              child: Text(
              '\$${amount.toStringAsFixed(0)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration:
                   BoxDecoration(
                    border: Border.all(width: 1, color: Colors.yellow),
                    color: Color.fromRGBO(220, 220, 220,1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingAmount,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.purple),
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Text(label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 15),
          ),
        ],
    );
  }
}