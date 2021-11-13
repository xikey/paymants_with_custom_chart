import 'package:flutter/material.dart';
import 'package:my_chart_test/models/transactions.dart';

import 'widgets/chart_widget.dart';
import 'widgets/new_transaction_widget.dart';
import 'widgets/transactions_list_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'PaymentsApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  List<Transactions> _transactions = [
    Transactions(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        name: 'buy car',
        amount: 29800.0),
    Transactions(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        name: 'buy milk',
        amount: 12.0),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addNewTransaction(Transactions ntx) {
    setState(() {
      widget._transactions.add(ntx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactionWidget(addNewTransaction: _addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      widget._transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeightSize = MediaQuery.of(context).size.height;
    final double bottomNavigationSize = 50;
    final appbar = AppBar(
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white),
      ),
    );
    return Scaffold(
      appBar: appbar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
        tooltip: 'add new one',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: bottomNavigationSize,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: (screenHeightSize-bottomNavigationSize-appbar.preferredSize.height) * 0.3,
              child: Chart(
                recentTransactions: widget._transactions,
              ),
            ),
            Container(
              width: double.infinity,
              height: (screenHeightSize-bottomNavigationSize-appbar.preferredSize.height) * 0.7,
              child: TransactionsListViewWidget(
                inputList: widget._transactions,
                deleteTransaction: (int index) {
                  print("${widget._transactions[index].name}");
                  _deleteTransaction(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
