import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/Data/repository.user/user_repository.dart';
import 'package:martify/Model/user_model.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/internet%20Exceptions/connectivity_services.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/signup_Screen/screens/verify_email.dart';

part 'update_user_details_event.dart';
part 'update_user_details_state.dart';

class UpdateUserDetailsBloc
    extends Bloc<UpdateUserDetailsEvent, UpdateUserDetailsState> {
  final UserModel user;

  UpdateUserDetailsBloc(this.user)
      : super(UpdateUserDetailsState(
          firstNameController: TextEditingController(text: user.firstName),
          lastNameController: TextEditingController(text: user.lastName),
          userNameController: TextEditingController(text: user.userName),
          phoneNoController: TextEditingController(text: user.phoneNumber),
          // Initialize other controllers if needed
        )) {
    on<UpdateFullName>(_updateFullName);
    on<UpdateEmail>(_updateEmail);
    on<UpdateUsername>(_updateUsername);
    on<UpdateProfilepicture>(_updateProfilepicture);
    on<HidePassword>(_hidePassword);
    on<UpdatePassword>(_updatePassword);
    on<UpdatePhoneNo>(_updatePhoneNo);
  }

  //------------------------------------------Hide Password----------------------------------------------------
  void _hidePassword(HidePassword event, Emitter<UpdateUserDetailsState> emit) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

//-------------------------------------User FullName--------------------------------------------------
  Future _updateFullName(
      UpdateFullName event, Emitter<UpdateUserDetailsState> emit) async {
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
      if (!state.updateUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }
      //Step4 ----- Update user first and last name in the firebase firestore
      Map<String, dynamic> name = {
        'firstName': state.firstNameController.text.trim(),
        'lastName': state.lastNameController.text.trim()
      };
      await UserRepository.updateSingleField(name);

      //Step5 Emit the updated user data to the UserDetailsBloc
      UserModel updatedUser = user.copyWith(
        firstName: state.firstNameController.text.trim(),
        lastName: state.lastNameController.text.trim(),
      );
      BlocProvider.of<UserDetailsBloc>(event.context)
          .add(UpdateUser(updatedUser));

      //Step6 -- Remove Loader
      FullScreenLoader.hide(event.context);

      //Step7 -- Show success message snackbar

      SnackbarService.showSucccess(
          context: event.context,
          message: "Your first and last name updated Successfully",
          heading: "Updated");

      //Step7 --- move to previous screen
      Navigator.pop(event.context);
    } catch (e) {
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

//-----------------------------------------User Email-----------------------------------------------------
  void _updateEmail(
      UpdateEmail event, Emitter<UpdateUserDetailsState> emit) async {
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
      if (!state.updateUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }

      ///Update email in fireabase auth
      await AuthenticationRepository.updateEmail(
          state.emailController.text.trim());
      //Step4 ----- Update user first and last name in the firebase firestore
      Map<String, dynamic> email = {
        'email': state.emailController.text.trim(),
      };
      await UserRepository.updateSingleField(email);

      // //Step5 Emit the updated user data to the UserDetailsBloc
      UserModel updatedUser = user.copyWith(
        email: state.emailController.text.trim(),
      );
      BlocProvider.of<UserDetailsBloc>(event.context)
          .add(UpdateUser(updatedUser));

      // Step6 -- Remove Loader
      FullScreenLoader.hide(event.context);

      // Step7 move to email verification
      MHelperFunctions.mostStrictAnimationNavigation(
          event.context,
          VerifyEmailScreen(
              email: state.emailController.text.trim(), functionvalue: 2));
    } catch (e) {
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

//-----------------------------------------User USERNAME---------------------------------------------------
  void _updateUsername(
      UpdateUsername event, Emitter<UpdateUserDetailsState> emit) async {
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
      if (!state.updateUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }
      //Step4 ----- Update user username in the firebase firestore
      Map<String, dynamic> newUserName = {
        'userName': state.userNameController.text.trim(),
      };
      await UserRepository.updateSingleField(newUserName);

      //Step5 Emit the updated user data to the UserDetailsBloc
      UserModel updatedUser = user.copyWith(
        userName: state.userNameController.text.trim(),
      );
      BlocProvider.of<UserDetailsBloc>(event.context)
          .add(UpdateUser(updatedUser));

      //Step6 -- Remove Loader
      FullScreenLoader.hide(event.context);

      //Step7 -- Show success message snackbar

      SnackbarService.showSucccess(
          context: event.context,
          message: "Your Username Updated Successfully",
          heading: "Updated");

      //Step7 --- move to previous screen
      Navigator.pop(event.context);
    } catch (e) {
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

//------------------------------------------User Phone No----------------------------------------------------
  void _updatePhoneNo(
      UpdatePhoneNo event, Emitter<UpdateUserDetailsState> emit) async {
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
      if (!state.updateUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }
      //Step4 ----- Update user first and last name in the firebase firestore
      Map<String, dynamic> newPhoneNumber = {
        'phoneNumber': state.phoneNoController.text.trim(),
      };
      await UserRepository.updateSingleField(newPhoneNumber);

      //Step5 Emit the updated user data to the UserDetailsBloc
      UserModel updatedUser = user.copyWith(
        phoneNumber: state.phoneNoController.text.trim(),
      );
      BlocProvider.of<UserDetailsBloc>(event.context)
          .add(UpdateUser(updatedUser));

      //Step6 -- Remove Loader
      FullScreenLoader.hide(event.context);

      //Step7 -- Show success message snackbar

      SnackbarService.showSucccess(
          context: event.context,
          message: "Your Phone Number updated Successfully",
          heading: "Updated");

      //Step7 --- move to previous screen
      Navigator.pop(event.context);
    } catch (e) {
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

  //-----------------------------------------User Password-----------------------------------------------------
  void _updatePassword(
      UpdatePassword event, Emitter<UpdateUserDetailsState> emit) async {
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
      if (!state.updateUserFormKey.currentState!.validate()) {
        FullScreenLoader.hide(event.context);
        return;
      }

      ///Update password in fireabase auth
      await AuthenticationRepository.updatePassword(
          state.passwordController.text.trim());

      // Step6 -- Remove Loader
      FullScreenLoader.hide(event.context);

      //Redirect to profile screen
      Navigator.of(event.context).pop();

      // show success message
      SnackbarService.showSucccess(
          context: event.context,
          message: "Your password was change successfully",
          heading: "Password Changed!");
    } catch (e) {
      FullScreenLoader.hide(event.context);
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

//------------------------------------------Update profile picture----------------------------------------------------
  void _updateProfilepicture(
      UpdateProfilepicture event, Emitter<UpdateUserDetailsState> emit) async {
    try {
      final dark = MHelperFunctions.isDarkMode(event.context);
      // Show dialog to choose between gallery and camera
      final ImageSource? selectedSource = await showDialog<ImageSource>(
        context: event.context,
        builder: (context) => AlertDialog(
          backgroundColor: dark ? MAppColors.dark : MAppColors.light,
          title: Center(
            child: Text(
              'Select Image Source',
              style: TextStyle(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: MAppColors.primary,
                ),
                title: Text(
                  'Gallery',
                  style: TextStyle(
                      color:
                          dark ? MAppColors.darkModeWhite : MAppColors.black),
                ),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: MAppColors.primary,
                ),
                title: Text('Camera',
                    style: TextStyle(
                        color: dark
                            ? MAppColors.darkModeWhite
                            : MAppColors.black)),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
            ],
          ),
        ),
      );

      // If no source is selected, return early
      if (selectedSource == null) return;

      // Pick the image based on the selected source (gallery or camera)
      final image = await ImagePicker().pickImage(
          source: selectedSource,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512,
          preferredCameraDevice: CameraDevice.front);

      if (image != null) {
        BlocProvider.of<UserDetailsBloc>(event.context)
            .add(const Chagneimagestatus(true));
        // Upload image
        final imageUrl =
            await UserRepository.uploadImage('Users/Images/Profile', image);

        // Update user image record in Firebase Database
        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await UserRepository.updateSingleField(json);

        // Update values in user model that fetch user details
        UserModel updatedUser = user.copyWith(profilePicture: imageUrl);
        BlocProvider.of<UserDetailsBloc>(event.context)
            .add(UpdateUser(updatedUser));

        // Show success message
        SnackbarService.showSucccess(
          context: event.context,
          message: "Your profile picture updated successfully",
          heading: "Updated!",
        );
        BlocProvider.of<UserDetailsBloc>(event.context)
            .add(const Chagneimagestatus(false));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      BlocProvider.of<UserDetailsBloc>(event.context)
          .add(const Chagneimagestatus(false));
      // Show error message
      SnackbarService.showError(
        context: event.context,
        message: e.toString(),
      );
    }
  }
}
