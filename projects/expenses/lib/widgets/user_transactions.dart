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
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionsList(transactions: _transactions),
        TransactionForm(
          titleController: titleController,
          valueController: valueController,
        )
      ],
    );
  }
}
