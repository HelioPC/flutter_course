import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productForm,
                  arguments: product,
                );
              },
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showCupertinoModalPopup<bool>(
                  context: context,
                  builder: (ctx) {
                    return CupertinoActionSheet(
                      title: const Text('Are you sure?'),
                      message: Text('Remove ${product.title} permanently'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () async {
                            if (context.mounted) {
                              Navigator.of(ctx).pop();
                            }
                            try {
                              await Provider.of<ProductList>(context,
                                      listen: false)
                                  .delete(product);
                            } catch (e) {
                              msg.showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          },
                          child: const Text('Confirm'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              color: Colors.red,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      title: Text(product.title),
    );
  }
}
