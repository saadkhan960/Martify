import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/device/device_utility.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed,
      this.centerTitle});
  final Widget? title;

  final bool showBackArrow;

  final IconData? leadingIcon;

  final List<Widget>? actions;

  final VoidCallback? leadingOnPressed;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Iconsax.arrow_left))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(
                      leadingIcon,
                    ))
                : null,
        title: title,
        actions: actions,
        centerTitle: centerTitle,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MDeviceUtility.getAppBarHeight());
}
