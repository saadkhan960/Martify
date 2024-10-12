import 'package:flutter/material.dart';
import 'package:martify/utils/constants/text_strings.dart';

class SignUpHeading extends StatelessWidget {
  const SignUpHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      MTexts.signupTitle,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
