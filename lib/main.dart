import 'dart:io';

import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

//void main() => runApp(MyApp());
void main() {
  //uncomment this to lock app to only potrait mode
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown
//  ]);
  return runApp(MyApp());
}

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
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))),
        home: _MyHomePage()
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<_MyHomePage> {
  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransactions),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showCart = false;

  void _addNewTransactions(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((obj) => obj.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar =Platform.isIOS?  CupertinoNavigationBar(
      middle: Text('Expense Tracker'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: ()=> startAddNewTransaction(context),
          )
        ],
      ),
    ): AppBar(
      title: Text('Expense Tracker'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context))
      ],
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
          mediaQuery.padding.top) *
          .7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody =SafeArea( child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart', style: Theme.of(context).textTheme.title,),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showCart,
                      onChanged: (val) {
                        setState(() {
                          _showCart = val;
                        });
                      })
                ],
              ),
            if(!isLandScape) Container(
              height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
                  .3,
              child: Chart(_recentTransaction),
            ),
            if(!isLandScape) txListWidget,
            if(isLandScape) _showCart
                ? Container(
              height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) * .7,
              child: Chart(_recentTransaction),
            )
                : txListWidget
          ],
        )));

    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar:appBar ,
    ) : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS?Container(): FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context)),
    );
  }
}
