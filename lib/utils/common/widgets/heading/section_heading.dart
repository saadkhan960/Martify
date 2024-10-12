import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MSectionHeading extends StatelessWidget {
  final VoidCallback? buttonOnPress;
  final String title, buttonText;
  final Color? textColor;
  final Color? buttonTextColor;
  final bool showActionButton;
  final Widget? usewidget;

  const MSectionHeading({
    super.key,
    this.buttonOnPress,
    required this.title,
    this.buttonText = "View All",
    this.textColor,
    this.showActionButton = true,
    this.buttonTextColor = MAppColors.primary,
    this.usewidget,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: textColor ??
                  (dark ? MAppColors.darkModeWhite : MAppColors.black)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          usewidget ??
              TextButton(
                  onPressed: buttonOnPress,
                  child: Text(
                    buttonText,
                    style: TextStyle(color: buttonTextColor),
                  )),
      ],
    );
  }
}
