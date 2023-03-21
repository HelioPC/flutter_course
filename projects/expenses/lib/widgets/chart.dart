import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentsTransactions});

  final List<Transaction> recentsTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double total = recentsTransactions.map((e) {
        return e.date.day == weekDay.day &&
                e.date.month == weekDay.month &&
                e.date.year == weekDay.year
            ? e.value
            : 0;
      }).fold(0, (p, c) => p + c);

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': total,
      };
    }).reversed.toList();
  }

  double get _totalValue {
    return groupedTransactions.fold(0, (a, b) => a + (b['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: groupedTransactions
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        label: e['day'] as String,
                        value: e['value'] as double,
                        percentage: (e['value'] as double) / _totalValue),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
