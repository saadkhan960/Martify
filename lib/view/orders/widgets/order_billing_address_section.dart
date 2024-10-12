import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/address_model.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/sizes.dart';

class OrderBillingAddressSection extends StatelessWidget {
  const OrderBillingAddressSection({super.key, required this.userAddress});
  final AddressModel userAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MSectionHeading(
          title: "Shipping Address",
          showActionButton: false,
        ),
        const SizedBox(height: MSizes.spaceBtwItems),
        Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Expanded(
              child: Text(
                userAddress.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.phone),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Text(
              userAddress.phoneNumber,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Iconsax.building_3),
            const SizedBox(width: MSizes.spaceBtwItems / 2),
            Expanded(
              child: Text(
                userAddress.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            )
          ],
        ),
      ],
    );
  }
}
