import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/Data/repository.user/user_repository.dart';
import 'package:martify/Model/user_model.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/signup_Screen/screens/verify_email.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  Timer? _timer;
  SignUpBloc() : super(SignUpState()) {
    on<SignUpPress>(_signUpPressd);
    on<PasswordShow>(_passwordShow);
    on<ConfirmPasswordShow>(_confirmPasswordShow);
    on<PrivacyPolicyCheck>(_privacyPolicyCheck);
    on<StartTimer>(_startTimer);
    on<TickTimer>(_tickTimer);
  }
  void _passwordShow(PasswordShow event, Emitter<SignUpState> emit) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void _confirmPasswordShow(
      ConfirmPasswordShow event, Emitter<SignUpState> emit) {
    emit(state.copyWith(hideConfirmPassword: !state.hideConfirmPassword));
  }

  void _privacyPolicyCheck(
      PrivacyPolicyCheck event, Emitter<SignUpState> emit) {
    emit(state.copyWith(privacyPolicy: event.value));
  }

  Future _signUpPressd(SignUpPress event, Emitter<SignUpState> emit) async {
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
      if (!state.signUpFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }
      // Step4-----Privacy Policy Check-------
      if (state.privacyPolicy == false) {
        FullScreenLoader.hide(event.context);
        SnackbarService.showWarning(
            context: event.context,
            message:
                "In order to create account, you must accept the Privacy Policy & Terms of Use",
            heading: "Accept Privacy Policy!");
      }
      // Step5------Register User in Firebase Auth
      else {
        final userName =
            "${state.firstNameController.text.trim()} ${state.lastNameController.text.trim()}";
        final userCredential =
            await AuthenticationRepository.registerWithEmailAndPassword(
                state.emailController.text.trim(),
                state.passwordController.text.trim(),
                userName);

        // Step6 ----Save Authenticated user data in firebase firestore
        final newUser = UserModel(
          id: userCredential.user!.uid,
          email: state.emailController.text.trim(),
          firstName: state.firstNameController.text.trim(),
          lastName: state.lastNameController.text.trim(),
          userName: state.userNameController.text.trim(),
          phoneNumber: state.phoneNoController.text.trim(),
          profilePicture: '',
        );
        await UserRepository.saveUserRecord(user: newUser).then((value) {
          FullScreenLoader.hide(event.context);

          //Move to Verification Screen
          MHelperFunctions.strictAnimationNavigation(
              event.context,
              VerifyEmailScreen(
                email: state.emailController.text,
                functionvalue: 1,
              ));

          // Clear the TextFormField controllers after successful registration
          state.firstNameController.clear();
          state.lastNameController.clear();
          state.userNameController.clear();
          state.emailController.clear();
          state.passwordController.clear();
          state.phoneNoController.clear();
          emit(state.copyWith(privacyPolicy: false));
        });
      }
    } catch (error) {
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(
          context: event.context, message: error.toString());
    }
  }

  // --------For Email Verfy resend timer-------
  void _startTimer(StartTimer event, Emitter<SignUpState> emit) {
    _timer?.cancel();
    emit(state.copyWith(timeLeft: 60, canResend: false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeLeft > 1) {
        add(TickTimer());
      } else {
        _timer?.cancel();
        add(TickTimer());
      }
    });
  }

  void _tickTimer(TickTimer event, Emitter<SignUpState> emit) {
    if (state.timeLeft > 1) {
      emit(state.copyWith(timeLeft: state.timeLeft - 1));
    } else {
      emit(state.copyWith(timeLeft: 0, canResend: true));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
