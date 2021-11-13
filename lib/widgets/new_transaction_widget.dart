import 'package:flutter/material.dart';
import 'package:my_chart_test/models/transactions.dart';
import 'package:intl/intl.dart';

class NewTransactionWidget extends StatefulWidget {
  const NewTransactionWidget({Key? key, required this.addNewTransaction})
      : super(key: key);

  final Function addNewTransaction;

  @override
  _NewTransactionWidgetState createState() => _NewTransactionWidgetState();
}

class _NewTransactionWidgetState extends State<NewTransactionWidget> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = null;

  void _checkInputDatas() {
    final enteredName = _nameController.text;
    final enteredValue = _valueController.text;

    if (enteredName.isEmpty) return;

    if (enteredValue == null || enteredValue.isEmpty) return;

    if (_selectedDate == null) return;

    final trx = Transactions(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: _selectedDate!,
        name: enteredName,
        amount: double.parse(enteredValue));

    widget.addNewTransaction(trx);

    Navigator.of(context).pop();
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 9,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Add New Transaction',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.edit),
                    hintText: "title",
                    labelText: "title",
                  ),
                )),
            Container(
                padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                child: TextField(
                  controller: _valueController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.attach_money_outlined),
                    border: OutlineInputBorder(),
                    hintText: "amount",
                    labelText: "amount",
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20, right: 0),
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 20),
                  child: TextButton(
                      onPressed: () {
                        _selectDate();
                      },
                      child: Text(
                        "Select Date",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 70, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(
                          'Add Transaction',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {_checkInputDatas();},
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
