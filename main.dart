
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planner/widgetsr/chart.dart';
import 'package:planner/widgetsr/new_transaction.dart';
import './widgetsr/transaction_list.dart';
import './models/Transaction.dart';


void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,]);
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'girlfriend ke kharche',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState()=>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction>_userTransactions = [
    //Transaction(
    //id:'t1',
    // title:'New SHOES',
    // amount:69.9,
    // date:DateTime.now(),
    // ),
    // Transaction(
    //  id:'t2',
    // title:'groceries',
    // amount:16.53,
    // date:DateTime.now(),
    //)
  ];

  List<Transaction> get _recentTransactions =>
      _userTransactions.where((tx){
          return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),)
        );
      }).toList();
  void _addTransactions(String txTitle,double txAmount,DateTime chosenDate) {
    final newTx=Transaction(
      title:txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),

    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(onTap:(){},child:NewTransaction(_addTransactions),behavior: HitTestBehavior.opaque,
      );},);
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx)=>
        tx.id==id
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    final appBar=AppBar(
        backgroundColor: Colors.purple,
        title: Text('monthly expenditure'),
        actions:<Widget>[
          IconButton(icon: Icon(Icons.add),onPressed:()=> _startAddNewTransaction(context),),
        ]
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           Container(
              height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*.3,
            child:Chart(_recentTransactions),),
          Container(
          height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*.7,
         child:TransactionList(_userTransactions,_deleteTransaction),),

        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _startAddNewTransaction(context),),
    );

   }
  }