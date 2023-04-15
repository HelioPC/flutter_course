import 'dart:io';
import 'dart:math';

import 'package:expenses/models/transaction.dart';
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
  });

  final Transaction tr;
  final void Function(String p1) removeTransaction;

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
    Platform.isIOS
        ? showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return CupertinoActionSheet(
                title: const Text('Delete'),
                message:
                    Text('Transaction \'${widget.tr.title}\' will be deleted'),
                actions: [
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      widget.removeTransaction(widget.tr.id);
                      Navigator.pop(context);
                    },
                    child: const Text('Confirm'),
                  ),
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          )
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
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

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(5);
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
            onPressed: (BuildContext context) {},
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
