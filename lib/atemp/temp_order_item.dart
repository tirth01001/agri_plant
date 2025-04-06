

import 'package:agriplant/atemp/temp_order_product.dart';
import 'package:agriplant/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


class TempOrderItem extends StatelessWidget {

  final List<Order> order;
  final int visibleProducts;
  final DateTime date;
  const TempOrderItem({super.key,required this.date, required this.order, this.visibleProducts = 2});


  @override
  Widget build(BuildContext context) {
    final products = order.take(visibleProducts).toList();
    final totalPrice = order
        .fold(0.0, (previousValue, element) => previousValue + element.product["price"]["new"]);
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Order: ${date.toString()}",
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "(${order.length} Items)",
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 5),
                Text(
                  "Rs.${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...List.generate(products.length, (index) {
              // final product = products[index];
              return TempOrderProduct(order: order[index],);
            }),
            if (order.length > 1) const SizedBox(height: 10),
            if (order.length > 1)
              Center(
                  child: TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.background,
                        ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(14),
                          itemCount: order.length,
                          itemBuilder: (context, index) {
                            // final product = order[index];
                            return TempOrderProduct(order: order[index],);
                          },
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(IconlyBold.arrowRight),
                label: const Text("View all"),
              ))
          ],
        ),
      ),
    );
  }
}
