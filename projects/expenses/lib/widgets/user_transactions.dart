import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/transaction_form.dart';
import 'package:expenses/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TransactionsList(transactions: _transactions),
        TransactionForm(
          addTransaction: _addTransaction,
        ),
      ],
    );
  }
}
