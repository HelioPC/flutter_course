import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      '${cart.totalAmount.toStringAsFixed(3)} \$',
                      style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .headlineLarge!
                            .color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CartButton(cart: cart),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CartItemWidget(cartItem: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isLoading,
      replacement: TextButton(
        onPressed: widget.cart.itemsCount == 0
            ? null
            : () async {
                setState(() => _isLoading = true);
                await Provider.of<OrderList>(
                  context,
                  listen: false,
                ).addOrder(widget.cart);
                widget.cart.clear();
                setState(() => _isLoading = false);
              },
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: const Text('Comprar'),
      ),
      child: const CircularProgressIndicator(),
    );
  }
}
