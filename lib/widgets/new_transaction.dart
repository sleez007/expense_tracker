import 'package:flutter/material.dart';

class NewTransaction  extends StatelessWidget {
  final Function _addToList;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this._addToList);

@override
Widget build(BuildContext context) {
return   Card(
  elevation: 5,
  child: Container(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Title'),
          controller: titleController,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Amount'),
          controller: amountController,
        ),
        FlatButton(
            child: Text('Add Transaction'),
            textColor: Colors.purple,
            onPressed: () {
              _addToList(titleController.text,double.parse(amountController.text));
              print(titleController.text);
              print(amountController.text);
            })
      ],
    ),
  ),
);
}
}