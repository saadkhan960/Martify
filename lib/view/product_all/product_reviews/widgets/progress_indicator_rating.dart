import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/product_all/product_reviews/widgets/progressindicator.dart';

class ProgressIndicatorAndRating extends StatelessWidget {
  const ProgressIndicatorAndRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "4.7",
              style: Theme.of(context).textTheme.displayLarge!.apply(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black),
            ),
            Text(
              "(139)",
              style: Theme.of(context).textTheme.bodySmall!.apply(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black),
            ),
          ]),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              Progressindicator(
                star: '5',
                progressValue: 0.7,
              ),
              Progressindicator(
                star: '4',
                progressValue: 0.4,
              ),
              Progressindicator(
                star: '3',
                progressValue: 0.3,
              ),
              Progressindicator(
                star: '2',
                progressValue: 0.1,
              ),
              Progressindicator(
                star: '1',
                progressValue: 0.2,
              )
            ],
          ),
        )
      ],
    );
  }
}
