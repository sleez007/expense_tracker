import 'dart:math';

import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.mediaQuery,
    @required Function deleteTransaction,
  }) : _deleteTransaction = deleteTransaction, super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function _deleteTransaction;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TransactionItemState();
  }

}

class _TransactionItemState extends State<TransactionItem>{
  Color _bgColor;

  @override
  void initState() {
    super.initState();
    const availableColors =[Colors.red, Colors.blue, Colors.black, Colors.purple];
    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child:  ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child:Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}')
            ),
          )

          ,),
        title:Text(widget.transaction.title, style: Theme.of(context).textTheme.title) ,
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing:widget.mediaQuery.size.width > 460?
        FlatButton.icon(
            onPressed: ()=>widget._deleteTransaction(widget.transaction.id),
            icon:const Icon(Icons.delete),
            textColor: Theme.of(context).errorColor ,
            label: const Text('Delete')
        )
            : IconButton(icon: Icon(Icons.delete,),onPressed: ()=>widget._deleteTransaction(widget.transaction.id),color: Theme.of(context).errorColor,),
      ),
    );
  }
}
