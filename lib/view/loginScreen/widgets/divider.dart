import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
          child: Divider(
              color: dark ? MAppColors.darkGrey : MAppColors.grey,
              thickness: 0.5,
              indent: 60,
              endIndent: 5)),
      Text(MTexts.orSignInWith.capitalize(),
          style: Theme.of(context).textTheme.labelMedium),
      Flexible(
          child: Divider(
              color: dark ? MAppColors.darkGrey : MAppColors.grey,
              thickness: 0.5,
              indent: 5,
              endIndent: 60)),
    ]);
  }
}
