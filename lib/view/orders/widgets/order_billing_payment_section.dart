import 'package:flutter/material.dart';
import 'package:martify/Model/payment_method_model.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class OrderBillingPaymentSection extends StatelessWidget {
  const OrderBillingPaymentSection({super.key, required this.paymentMethod});
  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        const MSectionHeading(
          title: "Payment Method",
          showActionButton: false,
        ),
        const SizedBox(height: MSizes.spaceBtwItems),
        Row(
          children: [
            MRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor:
                    dark ? MAppColors.darkModeWhite : MAppColors.white,
                padding: const EdgeInsets.all(MSizes.sm),
                child: Image.asset(
                  paymentMethod.image,
                  fit: BoxFit.contain,
                )),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Text(
              paymentMethod.name,
              style: Theme.of(context).textTheme.bodyLarge!.apply(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black),
            )
          ],
        ),
      ],
    );
  }
}
