import 'package:flutter/material.dart';
import 'package:martify/utils/device/device_utility.dart';
import 'package:martify/utils/constants/sizes.dart';

class OnBoardingSkip extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget title;
  const OnBoardingSkip(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MDeviceUtility.getAppBarHeight(),
        right: MSizes.defaultSpace,
        child: TextButton(
          onPressed: onPressed,
          child: title,
        ));
  }
}
