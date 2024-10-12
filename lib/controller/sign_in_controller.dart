import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/components/bottom_nav_menu.dart';
import 'package:martify/controller/user_controller/user_controller.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/signup_Screen/screens/verify_email.dart';

class SignInControllerz {
  SignInControllerz();

  static void checkUserEmailVeriy(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        MHelperFunctions.mostStrictAnimationNavigation(
            context, const BottomNavMenu());
        SnackbarService.showSucccess(
            context: context,
            message: "Welcome Back ${user.displayName}",
            heading: "Login Successfull");
      } else {
        MHelperFunctions.mostStrictAnimationNavigation(
            context,
            VerifyEmailScreen(
              email: user.email!,
              functionvalue: 1,
            ));
      }
    } else {
      SnackbarService.showError(
          context: context, message: "Something Went Wrong");
    }
  }

  static Future googleSignIn(BuildContext context) async {
    try {
      //------------Step1 Start Loading-------------
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);

      //Step2 ------Check Internet Connectivity---------
      ConnectivityService connectivityService = ConnectivityService(context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        FullScreenLoader.hide(context);
        SnackbarService.showError(
            context: context, message: "No Internet Connect");
        return;
      }

      //Step3 ---- Google Auth
      final userCredential = await AuthenticationRepository.signInWithGoogle();

      //Step4 -- save user record
      await UserController.saveUserRecordinUserModel(userCredential, context);

      //Step5 ---- Remove Loading
      FullScreenLoader.hide(context);

      // Step6 -- first check User Email Veriy then redirect to home page---
      checkUserEmailVeriy(context);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      FullScreenLoader.hide(context);
      SnackbarService.showError(context: context, message: error.toString());
    }
  }
}
