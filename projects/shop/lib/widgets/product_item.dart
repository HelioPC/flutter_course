import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          ],
        ),
      ),
      title: Text(product.title),
    );
  }
}
