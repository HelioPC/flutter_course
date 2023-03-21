import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required List<Transaction> transactions,
    required this.removeTransaction,
  }) : _transactions = transactions;

  final List<Transaction> _transactions;
  final void Function(String) removeTransaction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: _transactions.isEmpty
          ? const Center(
              child: Text('No Transactions'),
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FittedBox(
                          child:
                              Text('\$${_transactions.elementAt(index).value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions.elementAt(index).title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('dd MMM y')
                          .format(_transactions.elementAt(index).date),
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          removeTransaction(_transactions.elementAt(index).id),
                      color: Theme.of(context).colorScheme.error,
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
