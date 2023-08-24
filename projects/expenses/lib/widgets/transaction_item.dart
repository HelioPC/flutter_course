import 'dart:io';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.removeTransaction,
    required this.editTransaction,
  });

  final Transaction tr;
  final void Function(String p1) removeTransaction;
  final void Function(
    String? id,
    String title,
    double value,
    DateTime date,
  ) editTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  void _removeTransaction() {
    HapticFeedback.heavyImpact();
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Delete'),
          content: Text(
            'Transaction \'${widget.tr.title}\' will be deleted',
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.removeTransaction(widget.tr.id);
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  _showTransactionFormModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) {
        return TransactionForm(
          id: widget.tr.id,
          title: widget.tr.title,
          value: widget.tr.value,
          date: widget.tr.date,
          action: widget.editTransaction,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    double value = widget.tr.value;
    int i = value < 50
        ? 0
        : value < 500
            ? 1
            : value < 1000
                ? 2
                : value < 5000
                    ? 3
                    : value < 10000
                        ? 4
                        : 5;
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.key),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          widget.removeTransaction(widget.tr.id);
        }),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) => _showTransactionFormModal(),
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              _removeTransaction();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Platform.isIOS
          ? CupertinoListTile(
              leadingSize: 50,
              leading: CircleAvatar(
                backgroundColor: _backgroundColor,
                foregroundColor: Colors.white,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FittedBox(
                    child: Text('\$${widget.tr.value}'),
                  ),
                ),
              ),
              title: Text(
                widget.tr.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                DateFormat('dd MMM y').format(widget.tr.date),
              ),
            )
          : ListTile(
              leading: CircleAvatar(
                backgroundColor: _backgroundColor,
                foregroundColor: Colors.white,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FittedBox(
                    child: Text('\$${widget.tr.value}'),
                  ),
                ),
              ),
              title: Text(
                widget.tr.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                DateFormat('dd MMM y').format(widget.tr.date),
              ),
            ),
    );
  }
}
