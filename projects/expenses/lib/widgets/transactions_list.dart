import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required List<Transaction> transactions,
    required this.removeTransaction,
    required this.editTransaction,
  }) : _transactions = transactions;

  final List<Transaction> _transactions;
  final void Function(String) removeTransaction;
  final void Function(
    String? id,
    String title,
    double value,
    DateTime date,
  ) editTransaction;

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
        : ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final tr = _transactions.elementAt(index);
              return TransactionItem(
                key: GlobalObjectKey(tr.id),
                tr: tr,
                removeTransaction: removeTransaction,
                editTransaction: editTransaction,
              );
            },
          );
  }
}
