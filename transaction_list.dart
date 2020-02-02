import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget{

  final List<Transaction>transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context){
    return   transactions.isEmpty ? Column(children:<Widget>[
      Text('no transactions added yet'),
      SizedBox(height:10),
      Image.asset('assets/images/heman.png')
    ],):ListView.builder(itemBuilder:(ctx,index){
      return Card(
        elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical:8,
            horizontal:5,
          ),
          child: ListTile(leading: CircleAvatar(
          radius: 30,
          child:Padding(
            padding: EdgeInsets.all(6),
          child:FittedBox(
          child:Text('${transactions[index].amount}rs')),)),
        title: Text(
          transactions[index].title,
          style:Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transactions[index].date),),
            trailing:
                MediaQuery.of(context).size.width>460
            ?FlatButton.icon(
                  icon:Icon(Icons.delete),
                    label:Text('delte'),
                    color:Color.fromRGBO(50, 70, 90, 98),
                    onPressed: deleteTx(transactions[index].id))
                :IconButton(icon:Icon(Icons.delete,
              color: Color.fromRGBO(100, 0, 0, 1),),
              onPressed: ()=>deleteTx(transactions[index].id),),
      ));
      },
      itemCount: transactions.length,

    );



  }
}

