import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/device/device_utility.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  const CustomTabBar({
    super.key,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? MAppColors.black : MAppColors.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: MAppColors.primary,
          unselectedLabelColor: MAppColors.darkGrey,
          labelColor: dark ? MAppColors.darkModeWhite : MAppColors.primary,
          tabs: tabs),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MDeviceUtility.getAppBarHeight());
}
