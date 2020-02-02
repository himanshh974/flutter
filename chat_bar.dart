import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  final String label;
  final double spendingAmount;
  final double spendingPctofTotal;
  ChartBar(this.label,this.spendingAmount,this.spendingPctofTotal);
  @override
  Widget build(BuildContext context){
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(children: <Widget>[
        Container(
          height: constraints.maxHeight*.15,
          child:FittedBox(child:
        Text('${spendingAmount.toStringAsFixed(0)}rs'),),),

        Container(
          height: constraints.maxHeight*.6,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration:BoxDecoration(
                border:Border.all(color:Colors.grey,width:1.0),
                color:Color.fromRGBO(220,220,220,1),
                borderRadius:BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
                heightFactor: spendingPctofTotal,
                child:Container(decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor),))
          ],),
        ),

        Container(
          height:constraints.maxHeight*.15,
          child:Text(label),)
      ],);
    });

  }
}