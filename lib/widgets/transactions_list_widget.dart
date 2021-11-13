import 'package:flutter/material.dart';
import 'package:my_chart_test/models/transactions.dart';

class TransactionsListViewWidget extends StatelessWidget {
  const TransactionsListViewWidget(
      {Key? key, required this.inputList, required this.deleteTransaction})
      : super(key: key);

  final List<Transactions> inputList;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: inputList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return true;
              } else {
                return false;
              }
            },
            //direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                deleteTransaction(index);
              } else if (direction == DismissDirection.startToEnd) {}
            },
            background: Container(
              color: Colors.green,
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.redAccent,
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                alignment: Alignment.centerRight,
              ),
            ),
            key: Key(inputList[index].name),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      '\$${inputList[index].amount}',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
                  title: Text(inputList[index].name,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    inputList[index].date.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
