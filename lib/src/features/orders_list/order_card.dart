import 'package:ecommerce/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/src/constants/app_sizes.dart';
import 'package:ecommerce/src/features/orders_list/order_item_list_tile.dart';
import 'package:ecommerce/src/features/orders_list/order_status_label.dart';
import 'package:ecommerce/src/models/item.dart';
import 'package:ecommerce/src/models/order.dart';
import 'package:ecommerce/src/utils/currency_formatter.dart';
import 'package:ecommerce/src/utils/date_formatter.dart';

/// Shows all the details for a given order
class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.grey[400]!),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.p8)),
      ),
      child: Column(
        children: [
          OrderHeader(order: order),
          const Divider(height: 1, color: Colors.grey),
          OrderItemsList(order: order),
        ],
      ),
    );
  }
}

/// Order header showing the following:
/// - Total order amount
/// - Order date
class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    // TODO: Inject currency formatter
    final totalFormatted = kCurrencyFormatter.format(order.total);
    // TODO: Inject date formatter
    final dateFormatted = kDateFormatter.format(order.orderDate);
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order placed'.hardcoded.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  gapH4,
                  Text(dateFormatted),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total'.hardcoded.toUpperCase(),
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  gapH4,
                  Text(totalFormatted),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// List of items in the order
class OrderItemsList extends StatelessWidget {
  const OrderItemsList({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: OrderStatusLabel(order: order),
        ),
        for (var entry in order.items.entries)
          OrderItemListTile(
            item: Item(productId: entry.key, quantity: entry.value),
          ),
      ],
    );
  }
}
