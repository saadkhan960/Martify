import 'package:flutter/material.dart';
import 'package:martify/Model/Order%20Model/order_model.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class OrderStatusSection extends StatelessWidget {
  const OrderStatusSection({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MSectionHeading(
          title: "Order Status & Timeline",
          showActionButton: false,
        ),
        const SizedBox(height: MSizes.spaceBtwItems),
        Row(
          children: [
            Text(
              "Order Status:",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Text(
              order.status,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        Row(
          children: [
            Text(
              "Order No:",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Text(
              order.orderId,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        Row(
          children: [
            Text(
              "Order Date:",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Text(
              MHelperFunctions.getFormattedDate(order.orderDate),
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        Row(
          children: [
            Text(
              "Expected Delivery:",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Text(
              MHelperFunctions.getFormattedDate(order.deliveryDate!),
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            )
          ],
        ),
        // const SizedBox(height: MSizes.spaceBtwItems / 2),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       child: Text(
        //         textAlign: TextAlign.center,
        //         "This is the maximum expected delivery date. However, the order may arrive earlier. If the order is not received by the expected delivery date, please contact the helpline.",
        //         style: Theme.of(context)
        //             .textTheme
        //             .labelSmall!
        //             .apply(color: Colors.amber),
        //         softWrap: true,
        //         overflow: TextOverflow.visible,
        //       ),
        //     )
        //   ],
        // ),
      ],
    );
  }
}
