import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/divider_widget.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/view/signup_Screen/widgets/Signup_footer.dart';
import 'package:martify/view/signup_Screen/widgets/signup_form.dart';
import 'package:martify/view/signup_Screen/widgets/signup_heading.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(MSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Heading
                  const SignUpHeading(),
                  //Form
                  const SignUpForm(),
                  //Divider
                  DividerWidget(
                    text: MTexts.orSignUpWith.capitalize(),
                  ),
                  const SizedBox(height: MSizes.spacerBtwSections),
                  //Footer
                  const SignUpFooter()
                ],
              ))),
    );
  }
}
