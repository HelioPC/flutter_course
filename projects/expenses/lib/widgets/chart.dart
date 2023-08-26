import 'package:expenses/models/transaction.dart';
import 'package:expenses/models/transaction_list.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  List<Map<String, Object>> groupedTransactions(
    List<Transaction> recentsTransactions,
  ) {
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

  double _totalValue(List<Transaction> transactions) {
    return groupedTransactions(transactions)
        .fold(0, (a, b) => a + (b['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    final recentsTransactions =
        Provider.of<TransactionList>(context).mostRecents;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: groupedTransactions(recentsTransactions)
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: e['day'] as String,
                      value: e['value'] as double,
                      percentage: _totalValue(recentsTransactions) > 0
                          ? (e['value'] as double) /
                              _totalValue(recentsTransactions)
                          : 0,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
