import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/spacing_style.dart';
import 'package:martify/utils/common/widgets/divider_widget.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/view/loginScreen/widgets/footer.dart';
import 'package:martify/view/loginScreen/widgets/form.dart';
import 'package:martify/view/loginScreen/widgets/heading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: MSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Heading
                  const LoginHeading(),
                  //Form
                  const LoginForm(),
                  //Divider
                  DividerWidget(
                    text: MTexts.orSignInWith.capitalize(),
                  ),
                  const SizedBox(height: MSizes.spacerBtwSections),
                  //Footer
                  const LoginFooter()
                ],
              ))),
    );
  }
}
