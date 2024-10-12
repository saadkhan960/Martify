import 'package:flutter/material.dart';
import 'package:martify/components/bottom_nav_menu.dart';
import 'package:martify/utils/common/styles/spacing_style.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MSpacingStyle.paddingWithAppBarHeight * 1,
          child: Column(
            children: [
              Image(
                width: MHelperFunctions.screenwidth(context) * 0.6,
                image: const AssetImage(MImages.staticSuccessIllustration),
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              Text(
                MTexts.yourAccountCreatedTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              Text(
                MTexts.yourAccountCreatedSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        MHelperFunctions.mostStrictAnimationNavigation(
                            context, const BottomNavMenu());
                      },
                      child: const Text("Let's Go"))),
            ],
          ),
        ),
      ),
    );
  }
}
