import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/repository.user/user_repository.dart';
import 'package:martify/Model/user_model.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsState()) {
    on<FetchUser>(_onFetchUser);
    on<UpdateUser>(_onUpdateUser);
    on<Chagneimagestatus>(_chagneimagestatus);
    on<Fetchuserdetialsbool>(_fetchuserdetialsbool);
  }
  // Fetch user details
  Future<void> _onFetchUser(
      FetchUser event, Emitter<UserDetailsState> emit) async {
    try {
      emit(state.copyWith(profileLoading: true));
      ConnectivityService connectivityService =
          ConnectivityService(event.context);
      final bool isConnected = await connectivityService.checkConnectivity();
      if (!isConnected) {
        SnackbarService.showError(
            context: event.context, message: "No Internet Connect");
        return;
      } else {
        final user = await UserRepository.fetchUserDetails();
        emit(state.copyWith(user: user, profileLoading: false));
      }
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      emit(state.copyWith(
        profileLoading: false,
        errorMessage: 'Failed to fetch user data',
      ));
    }
  }

  // Update user details
  void _onUpdateUser(UpdateUser event, Emitter<UserDetailsState> emit) {
    try {
      emit(state.copyWith(user: event.updatedUser));
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
    }
  }

  // change status of image upload variable in state
  void _chagneimagestatus(
      Chagneimagestatus event, Emitter<UserDetailsState> emit) {
    emit(state.copyWith(imageUploading: event.value));
  }

  // when bool is false then fetch user function not work
  void _fetchuserdetialsbool(
      Fetchuserdetialsbool event, Emitter<UserDetailsState> emit) {
    if (state.fetchuserbool) {
      add(FetchUser(context: event.context));
      emit(state.copyWith(fetchuserbool: false));
    }
  }
}
