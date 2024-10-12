import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/loginScreen/login_screen.dart';
import 'package:martify/view/profile_screen/updateScreen/update_screen.dart';
part 're_auth_user_event.dart';
part 're_auth_user_state.dart';

class ReAuthUserBloc extends Bloc<ReAuthUserEvent, ReAuthUserState> {
  ReAuthUserBloc() : super(ReAuthUserState()) {
    on<HidePassword>(_hidePassword);
    on<ReAuthUserSubmit>(_reAuthUserSubmit);
    on<ReAuthUserBeforeNewEmail>(_reAuthUserBeforeNewEmail);
    on<ReAuthUserBeforeNewPassword>(_reAuthUserBeforeNewPassword);
  }

  void _hidePassword(HidePassword event, Emitter<ReAuthUserState> emit) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void _reAuthUserSubmit(
      ReAuthUserSubmit event, Emitter<ReAuthUserState> emit) async {
    try {
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);

      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();

      if (!isConnected) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showError(
            context: event.context, message: "No Internet Connect");
        return;
      }
      if (!state.reAuthUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      } else {
        //get login user email
        final userEmail = AuthenticationRepository.getUserEmail();
        //Reauthticate User
        await AuthenticationRepository.reAuthenticateWithEmailAndPass(
            email: userEmail, password: state.passwordController.text.trim());

        // //Now Dete User Account
        await AuthenticationRepository.deleteAccount();
        // remove controller
        state.emailController.clear();
        state.passwordController.clear();

        //remove Loader
        FullScreenLoader.hide(event.context);

        // //Navigate to login screen
        MHelperFunctions.mostStrictAnimationNavigation(
            event.context, const LoginScreen());
        // //Show Success Message
        SnackbarService.showSimpleMessage(
            context: event.context,
            message:
                "Your account has been successfully deleted. We're sorry to see you go 😥, but we hope to serve you again in the future.💗",
            heading: "Account Deleted",
            duration: 7);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

  // ------Re auth user before change its email address
  void _reAuthUserBeforeNewEmail(
      ReAuthUserBeforeNewEmail event, Emitter<ReAuthUserState> emit) async {
    try {
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);

      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();

      if (!isConnected) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showError(
            context: event.context, message: "No Internet Connect");
        return;
      }
      if (!state.reAuthUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      } else {
        //get login user email
        final userEmail = AuthenticationRepository.getUserEmail();
        //Reauthticate User
        await AuthenticationRepository.reAuthenticateWithEmailAndPass(
            email: userEmail, password: state.passwordController.text.trim());

        //Stop loading
        FullScreenLoader.hide(event.context);
        MHelperFunctions.strictAnimationNavigation(
            event.context,
            const UpdateScreen(
              appBarTitle: "New Email",
              formNo: 3,
              message:
                  "Enter your new email address here in order to update your email address",
            ));
        // remove controller
        state.emailController.clear();
        state.passwordController.clear();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

  // --------------------Re auth user before change its password---------------
  void _reAuthUserBeforeNewPassword(
      ReAuthUserBeforeNewPassword event, Emitter<ReAuthUserState> emit) async {
    try {
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);

      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();

      if (!isConnected) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showError(
            context: event.context, message: "No Internet Connect");
        return;
      }
      if (!state.reAuthUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      } else {
        //get login user email
        final userEmail = AuthenticationRepository.getUserEmail();
        //Reauthticate User
        await AuthenticationRepository.reAuthenticateWithEmailAndPass(
            email: userEmail, password: state.passwordController.text.trim());

        //Stop loading
        FullScreenLoader.hide(event.context);
        MHelperFunctions.strictAnimationNavigation(
            event.context,
            const UpdateScreen(
              appBarTitle: "New Password",
              formNo: 5,
              message:
                  "Enter your new password here in order to update your current password",
            ));
        // remove controller
        state.emailController.clear();
        state.passwordController.clear();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }
}
