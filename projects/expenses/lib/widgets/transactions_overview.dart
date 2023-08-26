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
    return FutureBuilder(
      future: Provider.of<TransactionList>(
        context,
        listen: false,
      ).loadTransactions(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snap.hasError) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Text(
                  'Error getting transactions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          );
        }

        return Consumer<TransactionList>(
          builder: (context, value, child) => Visibility(
            visible: value.items.isNotEmpty,
            replacement: child!,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                final tr = value.items.elementAt(index);
                return TransactionItem(
                  key: GlobalObjectKey(tr.id),
                  tr: tr,
                );
              },
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
