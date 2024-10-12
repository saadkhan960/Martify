import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/controller/sign_in_controller.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetStorage storage = GetStorage();
  LoginBloc() : super(LoginState()) {
    on<PasswordShow>(_passwordShow);
    on<RememberMe>(_rememberMe);
    on<LoginFormSubmit>(_loginFormSubmit);
  }

  void _passwordShow(PasswordShow event, Emitter<LoginState> emit) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void _rememberMe(RememberMe event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  Future _loginFormSubmit(
      LoginFormSubmit event, Emitter<LoginState> emit) async {
    try {
//------------Step1 Start Loading-------------
      FullScreenLoader.show(event.context, lottieAsset: MImages.docerAnimation);

      //Step2 ------Check Internet Connectivity---------
      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showError(
            context: event.context, message: "No Internet Connect");
        return;
      }

      // Step3 ----Form Validation-------
      if (!state.loginFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }

      //Step4-----Save user data in local storage if remember me is selected
      if (state.rememberMe) {
        await storage.write(
            'RememberMeEmail', state.emailController.text.trim());
        await storage.write(
            'RememberMePassword', state.passwordController.text.trim());
      } else {
        await storage.remove('RememberMeEmail');
        await storage.remove('RememberMePassword');
      }

      //Step5-----Login User-------------------------------
      await AuthenticationRepository.loginWithEmailAndPassword(
              context: event.context,
              email: state.emailController.text.trim(),
              password: state.passwordController.text.trim())
          .then((value) {
        // ----------Remove Loading----------
        FullScreenLoader.hide(event.context);

        // Clear the TextFormField controllers after successful registration
        state.emailController.clear();
        state.passwordController.clear();
        emit(state.copyWith(rememberMe: false));

        //-------Screen Redirect------------------
        // MHelperFunctions.mostStrictAnimationNavigation(
        //     event.context, const BottomNavMenu());
        SignInControllerz.checkUserEmailVeriy(event.context);
      });
    } catch (error) {
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(
          context: event.context, message: error.toString());
    }
  }
}
