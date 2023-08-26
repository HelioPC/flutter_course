import 'package:expenses/models/transaction.dart';
import 'package:expenses/utils/db_utils.dart';
import 'package:flutter/material.dart';

class TransactionList with ChangeNotifier {
  List<Transaction> _list = [];

  List<Transaction> get items => [..._list];
  List<Transaction> get mostRecents {
    return _list.where((t) {
      return t.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  Future<void> loadTransactions() async {
    final data = await DBUtils.getData('transactions');

    _list = data
        .map(
          (e) => Transaction(
            id: e['id'] as String,
            title: e['title'] as String,
            value: e['value'] as double,
            date: DateTime.fromMillisecondsSinceEpoch(e['milliseconds'] as int),
          ),
        )
        .toList();

    notifyListeners();
  }

  bool exists(String id) => [..._list].any(
        (tr) => tr.id == id,
      );

  Future<void> add(Transaction transaction) async {
    _list.add(
      Transaction(
        id: transaction.id,
        title: transaction.title,
        value: transaction.value,
        date: transaction.date,
      ),
    );

    DBUtils.insert(
      'transactions',
      {
        'id': transaction.id,
        'title': transaction.title,
        'value': transaction.value,
        'milliseconds': transaction.date.millisecondsSinceEpoch,
      },
    );

    notifyListeners();
  }

  Future<void> update(Transaction transaction) async {
    int index = items.indexWhere(
      (t) => t.id == transaction.id,
    );

    if (index >= 0) {
      _list[index] = transaction;

      DBUtils.update(
        'transactions',
        transaction.id,
        {
          'id': transaction.id,
          'title': transaction.title,
          'value': transaction.value,
          'milliseconds': transaction.date.millisecondsSinceEpoch,
        },
      );
    }

    notifyListeners();
  }

  Future<void> delete(String id) async {
    int index = items.indexWhere(
      (t) => t.id == id,
    );

    if (index >= 0) {
      final currentTransaction = _list[index];

      _list.remove(currentTransaction);

      DBUtils.remove('transactions', id);
    }

    notifyListeners();
  }
}
