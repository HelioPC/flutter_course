import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My orders'),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, index) {
          return OrderItem(order: orders.items[index]);
        },
      ),
    );
  }
}
