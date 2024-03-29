import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants/constants.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';

class OrderList with ChangeNotifier {
  final String _token;
  final String _uid;
  List<Order> _items = [];

  OrderList([this._items = const [], this._token = '', this._uid = '']);

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    List<Order> items = [];
    final response = await http.get(
        Uri.parse('${Constants.usersOrdersBaseUrl}/$_uid.json?auth=$_token'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      items.add(
        Order(
          id: key,
          date: DateTime.parse(value['date']),
          total: value['total'],
          products: (value['products'] as List<dynamic>)
              .map(
                (e) => CartItem(
                  id: e['id'],
                  productId: e['productId'],
                  name: e['name'],
                  quantity: e['quantity'],
                  price: e['price'],
                ),
              )
              .toList(),
        ),
      );
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.usersOrdersBaseUrl}/$_uid.json?auth=$_token'),
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
