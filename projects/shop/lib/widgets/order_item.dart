import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.order});

  final Order order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text('${widget.order.total.toStringAsFixed(2)} \$'),
        subtitle: Text(
          DateFormat('dd/mm/yyyy hh:mm').format(widget.order.date),
        ),
        children: widget.order.products
            .map(
              (p) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${p.quantity}x ${p.price} \$'),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
