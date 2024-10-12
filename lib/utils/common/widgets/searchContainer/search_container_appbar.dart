import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/device/device_utility.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class SearchContainerAppBar extends StatelessWidget {
  final String hintText;
  const SearchContainerAppBar({
    super.key,
    required this.hintText,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: MSizes.defaultSpace),
  });
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding!,
        child: Container(
          width: MDeviceUtility.getScreenWidth(context),
          padding: const EdgeInsets.all(MSizes.md),
          decoration: BoxDecoration(
              color: dark ? MAppColors.scafoldDark : MAppColors.white,
              borderRadius: BorderRadius.circular(MSizes.cardRadiusLg),
              border: Border.all(
                  color: dark ? MAppColors.scafoldDark : MAppColors.grey)),
          child: Row(children: [
            Icon(Iconsax.search_normal,
                color: dark ? MAppColors.darkModeWhite : MAppColors.darkerGrey),
            const SizedBox(width: MSizes.spaceBtwItems),
            Text(hintText,
                style: Theme.of(context).textTheme.bodySmall!.apply(
                    color:
                        dark ? MAppColors.darkModeWhite : MAppColors.darkGrey)),
          ]),
        ),
      ),
    );
  }
}
