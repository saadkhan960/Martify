import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class AuthLoadingScreen extends StatelessWidget {
  const AuthLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    height: 120,
                    width: 200,
                    image: AssetImage(dark
                        ? MImages.martifyDarkLogo
                        : MImages.martifyLightLogo)),
                const SizedBox(height: MSizes.spaceBtwItems),
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                    color: MAppColors.primary,
                    backgroundColor: dark ? MAppColors.dark : MAppColors.light,
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
