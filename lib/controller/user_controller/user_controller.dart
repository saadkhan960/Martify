import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/Data/repository.user/user_repository.dart';
import 'package:martify/Model/user_model.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/loginScreen/login_screen.dart';
import 'package:martify/view/profile_screen/Re-Authenticate/re_auth_screen.dart';

class UserController {
  // static Future saveUserRecordinUserModel(
  //     UserCredential? userCreadential, BuildContext context) async {
  //   if (userCreadential != null) {
  //     // Convert name into first and last name
  //     final nameParts =
  //         UserModel.nameparts(userCreadential.user!.displayName ?? '');
  //     final userName =
  //         UserModel.gneerateUserName(userCreadential.user!.displayName ?? '');
  //     // Map Data
  //     final user = UserModel(
  //         id: userCreadential.user!.uid,
  //         firstName: nameParts[0],
  //         lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
  //         userName: userName,
  //         email: userCreadential.user!.email ?? "",
  //         phoneNumber: userCreadential.user!.phoneNumber ?? "",
  //         profilePicture: userCreadential.user!.photoURL ?? "");

  //     //Save user data in firebase
  //     await UserRepository.saveUserRecord(user: user);
  //   }
  //   try {} catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //     FullScreenLoader.hide(context);
  //     SnackbarService.showError(context: context, message: error.toString());
  //   }
  // }
  static Future saveUserRecordinUserModel(
      UserCredential? userCreadential, BuildContext context) async {
    if (userCreadential != null) {
      final userRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(userCreadential.user!.uid);
      final docSnapshot = await userRef.get();

      if (!docSnapshot.exists) {
        // Convert name into first and last name
        final nameParts =
            UserModel.nameparts(userCreadential.user!.displayName ?? '');
        final userName =
            UserModel.gneerateUserName(userCreadential.user!.displayName ?? '');
        // Map Data
        final user = UserModel(
            id: userCreadential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            userName: userName,
            email: userCreadential.user!.email ?? "",
            phoneNumber: userCreadential.user!.phoneNumber ?? "",
            profilePicture: userCreadential.user!.photoURL ?? "");

        // Save user data in firebase
        await UserRepository.saveUserRecord(user: user);
      }
    }
  }

//user account delete pop up
  static void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final dark = MHelperFunctions.isDarkMode(context);
        return AlertDialog(
          backgroundColor: dark ? MAppColors.dark : MAppColors.light,
          title: const Center(
            child: Text(
              'Delete Account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: const Text(
            'Are you sure you want to permanently delete your account? Once deleted, all your data, including your profile and settings, will be lost and cannot be recovered. This action is irreversible.',
            textAlign: TextAlign.center,
          ),
          actions: [
            // Delete button
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                deleteUserAccount(context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            // Cancel button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MAppColors.primary,
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            )
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      },
    );
  }

  //Delete User ACCOUNT function

  static void deleteUserAccount(BuildContext context) async {
    try {
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);

      ConnectivityService connectivityService = ConnectivityService(context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        FullScreenLoader.hide(context);
        SnackbarService.showError(
            context: context, message: "No Internet Connect");
        return;
      } else {
        //first re auth user
        final auth = FirebaseAuth.instance.currentUser;
        final provider = auth!.providerData.map((e) => e.providerId).first;
        if (provider.isNotEmpty) {
          //re verify auth email
          if (provider == 'google.com') {
            await AuthenticationRepository.signInWithGoogle();
            await AuthenticationRepository.deleteAccount();
            FullScreenLoader.hide(context);
            MHelperFunctions.mostStrictAnimationNavigation(
                context, const LoginScreen());
          } else if (provider == 'password') {
            FullScreenLoader.hide(context);
            MHelperFunctions.simpleAnimationNavigation(
                context,
                const ReAuthScreen(
                  noteText: MTexts.reauthUserNote,
                  buttonText: "Delete Account Permanently",
                  onSubmitValueString: "delete",
                  buttoncColor: MAppColors.red,
                ));
          }
        }
      }
    } catch (e) {
      FullScreenLoader.hide(context);
      SnackbarService.showError(context: context, message: e.toString());
    }
  }

  //Before screen redirect check user login with google or manual login

  static void checkUserLoginMethod(
      {required BuildContext context,
      required Function() userFromGoogle,
      required Function() userFromPassword}) async {
    try {
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);

      ConnectivityService connectivityService = ConnectivityService(context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        FullScreenLoader.hide(context);
        SnackbarService.showError(
            context: context, message: "No Internet Connect");
        return;
      } else {
        //first re auth user
        final auth = FirebaseAuth.instance.currentUser;
        final provider = auth!.providerData.map((e) => e.providerId).first;
        if (provider.isNotEmpty) {
          //re verify auth email
          if (provider == 'google.com') {
            await AuthenticationRepository.signInWithGoogle();
            FullScreenLoader.hide(context);
            userFromGoogle();
          } else if (provider == 'password') {
            FullScreenLoader.hide(context);
            userFromPassword();
          }
        }
      }
    } catch (e) {
      FullScreenLoader.hide(context);
      SnackbarService.showError(context: context, message: e.toString());
    }
  }
}
