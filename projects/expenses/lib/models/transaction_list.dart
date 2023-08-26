import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList with ChangeNotifier {
  final List<Transaction> _list = [];

  List<Transaction> get items => [..._list];
  List<Transaction> get mostRecents {
    return _list.where((t) {
      return t.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
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

    notifyListeners();
  }

  Future<void> update(Transaction transaction) async {
    int index = items.indexWhere(
      (t) => t.id == transaction.id,
    );

    if (index >= 0) {
      _list[index] = transaction;
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
    }

    notifyListeners();
  }
}
