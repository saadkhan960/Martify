import 'package:flutter/material.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';

class ForgetHeading extends StatelessWidget {
  const ForgetHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MTexts.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: MSizes.sm),
        Text(
          MTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    );
  }
}
