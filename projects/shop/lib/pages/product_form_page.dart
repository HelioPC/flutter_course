import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(_updateImage);
    _imageUrlFocus.dispose();
    _imageUrlController.dispose();
  }

  void _updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();

    final _newProduct = Product(
      id: Random().nextDouble().toString(),
      title: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );

    print(_newProduct.description);
    print(_newProduct.price);
    print(_newProduct.imageUrl);
  }

  bool isValidUrl(String url) {
    final isValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    final endsWithFile =
        url.endsWith('.png') || url.endsWith('.jpg') || url.endsWith('.jpeg');

    return isValid && endsWithFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Form'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (value) {
                  final name = value ?? '';

                  if (name.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (name.length < 3) {
                    return '3 letters at least';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) => _formData['price'] =
                    double.parse(price?.replaceFirst(RegExp(','), '.') ?? '0'),
                focusNode: _priceFocus,
                validator: (value) {
                  final price = double.tryParse(value ?? '-1') ?? -1;

                  if (price <= 0) {
                    return '\'$price\' is an invalid price';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                focusNode: _descriptionFocus,
                validator: (value) {
                  final description = value ?? '';

                  if (description.trim().isEmpty) {
                    return 'This field is required';
                  }

                  if (description.length < 13) {
                    return '13 letters at least';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                      focusNode: _imageUrlFocus,
                      onChanged: (value) {
                        _submitForm();
                      },
                      validator: (value) {
                        final image = value ?? '';

                        if (!isValidUrl(image)) {
                          return 'Invalid image url';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text(
                            'Url',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
