import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/constants/constants.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final String _token;
  // ignore: prefer_final_fields
  List<Product> _items = [];

  ProductList(this._token, this._items);

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http
        .get(Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'));

    if (response.body == 'null') return;

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
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
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

  Future<void> update(Product product) async {
    int index = _items.indexWhere(
      (p) => p.id == product.id,
    );

    if (index >= 0) {
      await http.patch(
        Uri.parse(
            '${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
        body: jsonEncode({
          'name': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
    }
    _items[index] = product;
    notifyListeners();
  }

  Future<void> delete(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final sameProduct = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
            '${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, sameProduct);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
