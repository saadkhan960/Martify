import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/Order%20Model/order_model.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/orders/widgets/order_detail.dart';

class OrdersListItem extends StatelessWidget {
  const OrdersListItem({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Column(children: [
      InkWell(
        borderRadius: BorderRadius.circular(MSizes.cardRadiusLg),
        onTap: () => MHelperFunctions.simpleAnimationNavigation(
            context, OrderDetail(orderDetai: order)),
        child: MRoundedContainer(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          showBorder: true,
          backgroundColor: dark ? MAppColors.dark : MAppColors.light,
          borderColor: MAppColors.darkGrey,
          child: Column(
            children: [
              // -----1st Row-----------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.truck_fast),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.status,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: MAppColors.primary),
                          ),
                          Text(
                            MHelperFunctions.getFormattedDate(order.orderDate),
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  )
                ],
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              // -----2nd Row--------------------------------
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        const Icon(Iconsax.tag),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order",
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(order.orderId,
                                style: Theme.of(context).textTheme.bodyLarge)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        const Icon(Iconsax.calendar_1),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shipping Date",
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                                MHelperFunctions.getFormattedDate(
                                    order.deliveryDate!),
                                style: Theme.of(context).textTheme.bodyLarge)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: MSizes.spacerBtwSections),
    ]);
  }
}
