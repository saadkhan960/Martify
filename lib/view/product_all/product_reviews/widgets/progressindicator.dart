import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/device/device_utility.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class Progressindicator extends StatelessWidget {
  const Progressindicator(
      {super.key,
      required this.star,
      this.valueColor = MAppColors.primary,
      this.valueBgColor,
      required this.progressValue});
  final String star;
  final Color valueColor;
  final Color? valueBgColor;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            star,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? MAppColors.darkModeWhite : MAppColors.black),
          ),
        ),
        Expanded(
            flex: 10,
            child: SizedBox(
              width: MDeviceUtility.getScreenWidth(context) * 0.8,
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 9,
                backgroundColor:
                    valueBgColor ?? (dark ? MAppColors.dark : MAppColors.grey),
                borderRadius: BorderRadius.circular(7),
                valueColor: AlwaysStoppedAnimation(valueColor),
              ),
            ))
      ],
    );
  }
}
