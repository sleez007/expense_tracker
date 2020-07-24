import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions  =[
    Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.33,
        date: DateTime.now()
    )
  ];

  void _addNewTransactions(String txTitle, double txAmount){
    final newTx =  Transaction(title: txTitle, amount: txAmount, date: DateTime.now(), id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransactions),
        TransactionList(_userTransactions)
      ],
    );
  }
}

