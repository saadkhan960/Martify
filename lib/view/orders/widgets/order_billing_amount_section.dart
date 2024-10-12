import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class OrderBillingAmountSection extends StatelessWidget {
  const OrderBillingAmountSection(
      {super.key,
      required this.totalCartAmount,
      required this.shippingFee,
      required this.taxFee,
      required this.orderTotal});

  final String totalCartAmount;
  final String shippingFee;
  final String taxFee;
  final String orderTotal;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //Subtotal
        Row(
          children: [
            Expanded(
                child: Text("Subtotal",
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                        color: dark
                            ? MAppColors.darkModeWhite
                            : MAppColors.black))),
            Text("\$$totalCartAmount",
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black))
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        //Shipping Fee
        Row(
          children: [
            Expanded(
                child: Text("Shipping Fee",
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: dark
                            ? MAppColors.darkModeWhite
                            : MAppColors.black))),
            Text("\$$shippingFee",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black))
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        //Tax Fee
        Row(
          children: [
            Expanded(
                child: Text("Tax Fee",
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: dark
                            ? MAppColors.darkModeWhite
                            : MAppColors.black))),
            Text("\$$taxFee",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black))
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        Divider(
          color: dark ? MAppColors.darkerGrey : MAppColors.grey,
        ),
        //Order Total
        Row(
          children: [
            Expanded(
                child: Text("Order Total",
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                        color: dark
                            ? MAppColors.darkModeWhite
                            : MAppColors.black))),
            Text("\$$orderTotal",
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black))
          ],
        )
      ],
    );
  }
}
