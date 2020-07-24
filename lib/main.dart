import 'package:expense_tracker/models/transaction.dart';
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
            )
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

  final List<Transaction> _userTransactions  =[
//    Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
//    Transaction(
//        id: 't2',
//        title: 'Weekly Groceries',
//        amount: 16.33,
//        date: DateTime.now()
//    )
  ];

  void _addNewTransactions(String txTitle, double txAmount){
    final newTx =  Transaction(title: txTitle, amount: txAmount, date: DateTime.now(), id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
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
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('CHART'),
              elevation: 5,
            ),
          ),
          TransactionList(_userTransactions)
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: ()=>startAddNewTransaction(context)),
    );
  }
}
