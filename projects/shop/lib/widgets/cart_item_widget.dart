import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (direction) {
        return showCupertinoModalPopup<bool>(
          context: context,
          builder: (ctx) {
            return CupertinoActionSheet(
              title: const Text('Are you sure?'),
              message: Text('Remove ${cartItem.name} from cart'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Confirm'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(cartItem.name),
          subtitle: Text('${cartItem.price * cartItem.quantity} \$'),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '${cartItem.price} \$',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          trailing: Text('x${cartItem.quantity}'),
        ),
      ),
    );
  }
}
