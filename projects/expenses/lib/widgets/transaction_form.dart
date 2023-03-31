import 'package:expenses/widgets/adaptative_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                hintText: 'Title',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                hintText: 'Value (\$)',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(DateFormat('dd/MM/y').format(_selectedDate)),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text(
                    'Selecionar data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
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
