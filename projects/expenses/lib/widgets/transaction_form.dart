import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/models/transaction_list.dart';
import 'package:expenses/widgets/adaptative_button.dart';
import 'package:expenses/widgets/adaptative_date_picker.dart';
import 'package:expenses/widgets/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    this.transaction,
  });

  final Transaction? transaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  late DateTime _selectedDate;

  _handleAction() {
    final title = _titleController.text;
    final value =
        double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    if (widget.transaction != null) {
      Provider.of<TransactionList>(context, listen: false).update(
        Transaction(
          id: widget.transaction!.id,
          title: title,
          value: value,
          date: _selectedDate,
        ),
      );
    } else {
      Provider.of<TransactionList>(context, listen: false).add(
        Transaction(
          id: Random().nextDouble().toString(),
          title: title,
          value: value,
          date: _selectedDate,
        ),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _titleController.text = widget.transaction?.title ?? '';
    _valueController.text = widget.transaction?.value != null
        ? widget.transaction!.value.toString()
        : '';
    _selectedDate = widget.transaction?.date ?? DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 30,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AdaptativeTextfield(
            controller: _titleController,
            label: 'Title',
            onSubmitted: (_) => _handleAction(),
          ),
          AdaptativeTextfield(
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            label: 'Value (\$)',
            onSubmitted: (_) => _handleAction(),
          ),
          AdaptativeDatePicker(
            selectedDate: _selectedDate,
            onDateChanged: (newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AdaptativeButton(
                text:
                    widget.transaction?.id != null ? 'Save' : 'New transaction',
                onPressed: _handleAction,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
