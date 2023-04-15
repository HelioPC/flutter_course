import 'package:expenses/widgets/adaptative_button.dart';
import 'package:expenses/widgets/adaptative_date_picker.dart';
import 'package:expenses/widgets/adaptative_textfield.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.action,
    this.title,
    this.value,
    this.date,
    this.id,
  });

  final String? id;
  final String? title;
  final double? value;
  final DateTime? date;
  final void Function(
    String? id,
    String title,
    double value,
    DateTime date,
  ) action;

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

    widget.action(widget.id, title, value, _selectedDate);
  }

  @override
  void initState() {
    _titleController.text = widget.title ?? '';
    _valueController.text = widget.value != null ? widget.value.toString() : '';
    _selectedDate = widget.date ?? DateTime.now();
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
                text: widget.id != null ? 'Save' : 'New transaction',
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
