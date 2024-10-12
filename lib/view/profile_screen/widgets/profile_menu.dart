import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Iconsax.edit_24,
    this.iconSize = 18,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final double iconSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MSizes.spaceBtwItems / 1.5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 5,
            child: Text(subtitle,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black),
                overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Icon(
                icon,
                size: iconSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
