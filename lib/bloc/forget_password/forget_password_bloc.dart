import 'dart:async';

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
import 'package:martify/view/forgetScreen/screen/reset_passsword.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  Timer? _timer;
  ForgetPasswordBloc() : super(ForgetPasswordState()) {
    on<ForgetPassword>(_forgetPassword);
    on<StartTimer>(_startTimer);
    on<TickTimer>(_tickTimer);
  }

  _forgetPassword(
      ForgetPassword event, Emitter<ForgetPasswordState> emit) async {
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
      if (!state.forgetFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }

      //Step4 -- Email send
      await AuthenticationRepository.resetPassWithEmailAndPassword(
          email: state.emailController.text.trim());

      //Step5 --Stop loading
      FullScreenLoader.hide(event.context);

      //Step6 --Redirect to email reset screen
      MHelperFunctions.mostStrictAnimationNavigation(
          event.context,
          ResetPasssword(
            email: state.emailController.text.trim(),
          ));

      //Step 7 --- show success message snackbar
      SnackbarService.showSucccess(
          context: event.context,
          message: "Please check you inbox to reset your password",
          heading: "Email Send Successfully");

      // Step 8 ---Clear the TextFormField controllers after successful registration
      state.emailController.clear();
    } catch (error) {
      FullScreenLoader.hide(event.context);
      if (kDebugMode) {
        print("Error on forgotpassword bloc event $error");
      }
      SnackbarService.showError(
          context: event.context, message: error.toString());
    }
  }

  void _startTimer(StartTimer event, Emitter<ForgetPasswordState> emit) {
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

  void _tickTimer(TickTimer event, Emitter<ForgetPasswordState> emit) {
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
