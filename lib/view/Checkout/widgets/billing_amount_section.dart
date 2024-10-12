import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Checkout/checkout_bloc.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final values = context.watch<CheckoutBloc>().state;
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
            Text("\$${values.totalCartAmount}",
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
            Text("\$${values.shippingFee}",
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
            Text("\$${values.taxFee}",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black))
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        //Order Total
        Row(
          children: [
            Expanded(
                child: Text("Order Total",
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                        color: dark
                            ? MAppColors.darkModeWhite
                            : MAppColors.black))),
            Text("\$${values.orderTotal}",
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black))
          ],
        )
      ],
    );
  }
}
