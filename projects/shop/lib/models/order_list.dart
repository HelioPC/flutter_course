import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants/constants.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.ordersBaseUrl}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values
            .map(
              (e) => {
                'id': e.id,
                'productId': e.productId,
                'name': e.name,
                'quantity': e.quantity,
                'price': e.price,
              },
            )
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
