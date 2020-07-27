import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
            button: TextStyle(color: Colors.white)
          ),

          appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold)) )

        ),
        home: _MyHomePage());
  }
}

class _MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }

}

class _MyHomePageState extends State<_MyHomePage> {


  void startAddNewTransaction(BuildContext context){
    showModalBottomSheet(context : context, builder: (bCtx){
      return GestureDetector(
        onTap: (){},
        child:  NewTransaction(_addNewTransactions),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  final List<Transaction> _userTransactions  =[];

  List<Transaction> get _recentTransaction{
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(String txTitle, double txAmount, DateTime selectedDate){
    final newTx =  Transaction(title: txTitle, amount: txAmount, date: selectedDate, id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((obj)=> obj.id == id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: ()=>startAddNewTransaction(context))
          ],
        ),
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(_recentTransaction),
          TransactionList(_userTransactions, _deleteTransaction)
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: ()=>startAddNewTransaction(context)),
    );
  }
}
