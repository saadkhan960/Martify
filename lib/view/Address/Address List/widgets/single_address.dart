import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/address_model.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress(
      {super.key,
      required this.address,
      required this.onTap,
      required this.onLongPress});
  final AddressModel address;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final selectedAddressId =
        context.watch<AddressBloc>().state.selectedAddress.id;
    final selectedAddress = address.id == selectedAddressId;
    final dark = MHelperFunctions.isDarkMode(context);
    return InkWell(
      borderRadius: BorderRadius.circular(MSizes.cardRadiusLg),
      onTap: onTap,
      onLongPress: onLongPress,
      child: MRoundedContainer(
        padding: const EdgeInsets.all(MSizes.md),
        width: double.infinity,
        showBorder: true,
        backgroundColor:
            context.watch<AddressBloc>().state.selectedDeleteAddress ==
                    address.id
                ? MAppColors.grey.withOpacity(0.5)
                : selectedAddress
                    ? MAppColors.primary.withOpacity(0.5)
                    : Colors.transparent,
        borderColor: selectedAddress
            ? Colors.transparent
            : dark
                ? MAppColors.darkerGrey
                : MAppColors.grey,
        margin: const EdgeInsets.only(bottom: MSizes.spaceBtwItems),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(
                selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress
                    ? dark
                        ? MAppColors.light
                        : MAppColors.dark
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: MSizes.sm / 2,
                ),
                Text(
                  address.phoneNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: MSizes.sm / 2,
                ),
                Text(
                  address.toString(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: MSizes.sm / 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
