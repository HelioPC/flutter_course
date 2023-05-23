import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl =
      'https://flutter-shop-6b598-default-rtdb.firebaseio.com/products.json';
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      _items.add(
        Product(
          id: key,
          title: value['name'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavorite: value['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (!hasId) {
      return add(newProduct);
    } else {
      return update(newProduct);
    }
  }

  Future<void> add(Product product) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode({
        'name': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> update(Product product) {
    int index = _items.indexWhere(
      (p) => p.id == product.id,
    );

    if (index >= 0) {
      _items[index] = product;
    } else {}
    notifyListeners();

    return Future.value();
  }

  void delete(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.remove(product);
      notifyListeners();
    }
  }
}
