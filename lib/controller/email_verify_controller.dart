import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/components/bottom_nav_menu.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/signup_Screen/screens/success_screen.dart';

class EmailVerifyController {
  static final _auth = FirebaseAuth.instance;
  static Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await AuthenticationRepository.sendEmailVerification();
      SnackbarService.showSucccess(
          context: context,
          message: "Please check your inbox and verify your email address",
          heading: "Email Send Successfully");
    } catch (e) {
      SnackbarService.showError(
          context: context,
          message: "${e.toString()}, Please Try again after few mintues",
          heading: "Something Went Wrong");
    }
  }

  //Auto Check
  static setTimerForAutoRedirect(BuildContext context, int functionvalue) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _auth.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        if (functionvalue == 1) {
          MHelperFunctions.mostStrictAnimationNavigation(
              context, const SuccessScreen());
        }
        if (functionvalue == 2) {
          context.read<UserDetailsBloc>().add(FetchUser(context: context));
          MHelperFunctions.mostStrictAnimationNavigation(
              context, const BottomNavMenu());
        } else {
          if (kDebugMode) {
            print("function value is incoorect");
          }
        }
      }
    });
  }

  //Manually Check
  static checkEmailVerificationStatus(BuildContext context) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      MHelperFunctions.mostStrictAnimationNavigation(
          context, const SuccessScreen());
    } else {
      SnackbarService.showWarning(
          context: context,
          message:
              "Please Verify Your Email first. In order to Continue. If you dont recive your verification email try resend email button below",
          heading: "Email Not Verified");
    }
  }
}
