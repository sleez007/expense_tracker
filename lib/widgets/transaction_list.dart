import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/TransactionItem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return  transactions.isEmpty
            ? LayoutBuilder(builder: (context, constraints){
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight *.6,
                      child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover)
                  )
                ],
              );
    },)
            : ListView(
              children: transactions.map((tx)=>TransactionItem(key: ValueKey(tx.id),transaction: tx, mediaQuery: mediaQuery, deleteTransaction: _deleteTransaction)).toList()

//                itemCount: transactions.length,
//                itemBuilder: (ctx, index) {
//                  return
//                }
                );
  }
}

