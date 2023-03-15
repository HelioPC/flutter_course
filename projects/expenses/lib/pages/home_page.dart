import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'PS Card',
      value: 15.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'FIFA 23',
      value: 89.99,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            child: Card(
              color: Colors.purple,
              elevation: 5,
              child: Text(
                'Graph',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: _transactions
                .map(
                  (e) => Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '€ ${e.value}',
                            style: const TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('dd MMM y').format(e.date),
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Card(
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
                        onPressed: () {
                          print(
                              '${titleController.text} and ${valueController.text}');
                        },
                        child: const Text('New transaction'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
