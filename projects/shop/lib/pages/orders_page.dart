import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Consumer<OrderList>(builder: (context, orders, child) {
                return ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (context, index) {
                    return OrderItem(order: orders.items[index]);
                  },
                );
              });
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return const Center(
                child: Text('An error occur while getting orders'),
              );
          }
        },
      ),
    );
  }
}
