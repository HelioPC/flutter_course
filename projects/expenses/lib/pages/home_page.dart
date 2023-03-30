import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transaction_form.dart';
import 'package:expenses/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showCart = true;

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  _showTransactionFormModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) {
        return TransactionForm(addTransaction: _addTransaction);
      },
    );
  }

  List<Transaction> get _recentsTransactions {
    return _transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Expenses App'),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () => setState(() {
              _showCart = !_showCart;
            }),
            icon: Icon(_showCart ? Icons.list : Icons.pie_chart),
          ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show graph'),
                  Switch(
                    value: _showCart,
                    onChanged: (value) {
                      setState(() {
                        _showCart = value;
                      });
                    },
                  ),
                ],
              ),*/
              if (_showCart || !isLandscape)
                SizedBox(
                  height: availableHeight * (isLandscape ? .70 : .25),
                  child: Chart(recentsTransactions: _recentsTransactions),
                ),
            if (!_showCart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : .70),
                child: TransactionsList(
                  transactions: _transactions,
                  removeTransaction: _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTransactionFormModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
