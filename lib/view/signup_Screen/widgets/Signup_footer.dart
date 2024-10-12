import 'package:flutter/material.dart';
import 'package:martify/controller/sign_in_controller.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70,
        decoration: BoxDecoration(
            border: Border.all(color: MAppColors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: IconButton(
          onPressed: () {
            SignInControllerz.googleSignIn(context);
          },
          icon: const Image(
            width: MSizes.iconMd,
            height: MSizes.iconMd,
            image: AssetImage(MImages.google),
          ),
        ),
      ),
    );
  }
}
