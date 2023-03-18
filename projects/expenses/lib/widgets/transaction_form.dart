import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, required this.addTransaction});

  final void Function(String, double) addTransaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController valueController = TextEditingController();

  _addTransaction() {
    final title = titleController.text;
    final value =
        double.tryParse(valueController.text.replaceAll(',', '.')) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.addTransaction(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple)),
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple)),
                  hintText: 'Value (\$)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.purple,
                    ),
                  ),
                  onPressed: _addTransaction,
                  child: const Text('New transaction'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
