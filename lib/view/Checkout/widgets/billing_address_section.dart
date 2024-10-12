import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/address_model.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/Address/Address%20List/address_list.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userAddress = context.watch<AddressBloc>().state.selectedAddress;
    if (userAddress == AddressModel.empty()) {
      return Column(
        children: [
          MSectionHeading(
            title: "Shipping Address",
            buttonText: "Change",
            buttonOnPress: () {
              MHelperFunctions.simpleAnimationNavigation(
                  context, const AddressList());
            },
          ),
          const SizedBox(height: MSizes.spaceBtwItems / 2),
          Text(
            "Shipping Address Not Set Please Click on change to set Address",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: MAppColors.warning),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MSectionHeading(
          title: "Shipping Address",
          buttonText: "Change",
          buttonOnPress: () {
            MHelperFunctions.simpleAnimationNavigation(
                context, const AddressList());
          },
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
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
