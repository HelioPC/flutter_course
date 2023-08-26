import 'package:expenses/models/transaction_list.dart';
import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsOverview extends StatelessWidget {
  const TransactionsOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionList>(context).items;

    return transactions.isEmpty
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
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tr = transactions.elementAt(index);
              return TransactionItem(
                key: GlobalObjectKey(tr.id),
                tr: tr,
              );
            },
          );
  }
}
