import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/user_transactions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
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
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
