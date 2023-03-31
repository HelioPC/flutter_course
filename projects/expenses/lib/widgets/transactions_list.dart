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
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
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
                  trailing: MediaQuery.of(context).size.width > 480
                      ? ElevatedButton.icon(
                          onPressed: () => removeTransaction(
                              _transactions.elementAt(index).id),
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                        )
                      : IconButton(
                          onPressed: () => removeTransaction(
                              _transactions.elementAt(index).id),
                          color: Theme.of(context).colorScheme.error,
                          icon: const Icon(Icons.delete),
                        ),
                ),
              );
            },
          );
  }
}
