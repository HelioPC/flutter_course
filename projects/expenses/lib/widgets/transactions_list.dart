import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
              final tr = _transactions.elementAt(index);
              return Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),

                // The start action pane is the one at the left or the top side.
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (BuildContext context) {},
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {},
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Share',
                    ),
                  ],
                ),

                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 2,
                      onPressed: (BuildContext context) {},
                      backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Archive',
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) {},
                      backgroundColor: const Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.save,
                      label: 'Save',
                    ),
                  ],
                ),

                // The child of the Slidable is what the user sees when the
                // component is not dragged.
                child: const ListTile(title: Text('Slide me')),
              );
            },
          );
  }
}
