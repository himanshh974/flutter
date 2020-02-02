  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function add;

  NewTransaction(this.add);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}
class _NewTransactionState extends State<NewTransaction>{
  final titleController=TextEditingController();
  final amountController=TextEditingController();
  DateTime selectedDate;

  void submitData(){
    final enteredTitle=titleController.text;
    final enteredAmount=double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount<=0 || selectedDate==null){
      return;
    }

    widget.add(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(context:context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now(),).then((pickedDate){
      if(pickedDate==null){
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }
  @override
    Widget build(BuildContext context){
      return Card(elevation:5,
        child:Container(
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(decoration: InputDecoration(labelText: ('title')),controller: titleController,onSubmitted: (_)=>submitData(),),
          TextField(decoration: InputDecoration(labelText: ('amount')),controller: amountController,onSubmitted:(_)=>submitData() ,),
          Container(
          height:70,
          child:
          Row(children:<Widget>[
            Text(selectedDate==null?'no date choosen':DateFormat.yMd().format(selectedDate),),
            FlatButton(
              textColor:Theme.of(context).primaryColor,
              child:Text('choose date',style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: _presentDatePicker,
            ),
          ],),),
          RaisedButton(child: Text('add transaction'),textColor: Colors.purple,onPressed:submitData,

          ),
        ],),),);
    }
  }
