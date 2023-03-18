import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/transaction_form.dart';
import 'package:expenses/widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'PS Card',
      value: 15.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'FIFA 23',
      value: 89.99,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _showTransactionFormModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TransactionForm(addTransaction: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              child: Card(
                color: Colors.purple,
                elevation: 5,
                child: Text(
                  'Graph',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TransactionsList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTransactionFormModal,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
