import 'package:expenses/widgets/adaptative_button.dart';
import 'package:expenses/widgets/adaptative_date_picker.dart';
import 'package:expenses/widgets/adaptative_textfield.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, required this.addTransaction});

  final void Function(String, double, DateTime) addTransaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _addTransaction() {
    final title = _titleController.text;
    final value =
        double.tryParse(_valueController.text.replaceAll(',', '.')) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.addTransaction(title, value, _selectedDate);
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
            onSubmitted: (_) => _addTransaction(),
          ),
          AdaptativeTextfield(
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            label: 'Value (\$)',
            onSubmitted: (_) => _addTransaction(),
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
                text: 'New transaction',
                onPressed: _addTransaction,
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
