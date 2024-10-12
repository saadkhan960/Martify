import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:martify/bloc/user_details/user_details_bloc.dart';
import 'package:martify/controller/user_controller/user_controller.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/bannerimages/rounded_image.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/profile_screen/Re-Authenticate/re_auth_screen.dart';
import 'package:martify/view/profile_screen/updateScreen/update_screen.dart';
import 'package:martify/view/profile_screen/widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              //----Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    BlocBuilder<UserDetailsBloc, UserDetailsState>(
                      buildWhen: (previous, current) =>
                          previous.user.profilePicture !=
                              current.user.profilePicture ||
                          previous.imageUploading != current.imageUploading,
                      builder: (context, state) {
                        final networkImage = state.user.profilePicture;
                        return state.imageUploading
                            ? const MShimmerLoader(
                                width: 80,
                                height: 80,
                                radius: 80,
                              )
                            : MRoundedImage(
                                imageurl: networkImage.isEmpty
                                    ? MImages.user
                                    : state.user.profilePicture,
                                isNetworkImage: networkImage.isNotEmpty,
                                height: 80,
                                width: 80,
                                borderRadius: 100,
                                padding: const EdgeInsets.all(0),
                                fit: BoxFit.cover,
                              );
                      },
                    ),
                    BlocProvider(
                      create: (context) => UpdateUserDetailsBloc(
                          BlocProvider.of<UserDetailsBloc>(context).state.user),
                      child: BlocBuilder<UpdateUserDetailsBloc,
                          UpdateUserDetailsState>(
                        builder: (context, state) {
                          return TextButton(
                              onPressed: () {
                                context.read<UpdateUserDetailsBloc>().add(
                                    UpdateProfilepicture(context: context));
                              },
                              child: Text(
                                "Change Profile Picture",
                                style: TextStyle(
                                    color: dark
                                        ? MAppColors.darkModeWhite
                                        : MAppColors.black),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //------Details
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: MSizes.spaceBtwItems),
              const MSectionHeading(
                title: "Profile Informations",
                showActionButton: false,
              ),
              const SizedBox(height: MSizes.spaceBtwItems),

              //Profile Menus
              //Name
              BlocSelector<UserDetailsBloc, UserDetailsState, String>(
                selector: (state) => state.user.userFullName,
                builder: (context, value) {
                  return ProfileMenu(
                    title: "Name",
                    subtitle: value == "" ? "Click to set Name" : value,
                    onTap: () {
                      MHelperFunctions.simpleAnimationNavigation(
                          context,
                          const UpdateScreen(
                            formNo: 1,
                            appBarTitle: 'Update Name',
                            message:
                                "Use real Name for easy verification. This name will appare on several pages",
                          ));
                    },
                  );
                },
              ),
              //User  Name
              BlocSelector<UserDetailsBloc, UserDetailsState, String>(
                selector: (state) => state.user.userName,
                builder: (context, value) {
                  return ProfileMenu(
                    title: "Username",
                    subtitle: value == "" ? "Click to set username" : value,
                    onTap: () {
                      MHelperFunctions.simpleAnimationNavigation(
                          context,
                          const UpdateScreen(
                            formNo: 2,
                            appBarTitle: 'Update Username',
                          ));
                    },
                  );
                },
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: MSizes.spaceBtwItems),
              const MSectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              //User ID
              BlocSelector<UserDetailsBloc, UserDetailsState, String>(
                selector: (state) => state.user.id,
                builder: (context, value) {
                  return ProfileMenu(
                    title: "User-ID",
                    subtitle: value == "" ? "Something Wen Wrong" : value,
                    icon: Iconsax.copy,
                    onTap: () {
                      MHelperFunctions.copyTextWithSnackBarMessage(
                          text: value, context: context);
                    },
                  );
                },
              ),
              BlocSelector<UserDetailsBloc, UserDetailsState, String>(
                selector: (state) => state.user.email,
                builder: (context, value) {
                  return ProfileMenu(
                    title: "Email",
                    subtitle: value == "" ? "Click to set Email" : value,
                    onTap: () {
                      UserController.checkUserLoginMethod(
                        context: context,
                        userFromGoogle: () {
                          MHelperFunctions.simpleAnimationNavigation(
                              context,
                              const UpdateScreen(
                                appBarTitle: "New Email",
                                formNo: 3,
                                message:
                                    "Enter your new email address here in order to update your email address",
                              ));
                        },
                        userFromPassword: () {
                          MHelperFunctions.simpleAnimationNavigation(
                              context,
                              const ReAuthScreen(
                                buttonText: "Verify",
                                onSubmitValueString: "email",
                                passwordFieldLabel: "Current Password",
                              ));
                        },
                      );
                    },
                  );
                },
              ),
              // -----------Password change----------------
              ProfileMenu(
                title: "Password",
                subtitle: "Click to change Password",
                onTap: () {
                  UserController.checkUserLoginMethod(
                    context: context,
                    userFromGoogle: () {
                      MHelperFunctions.simpleAnimationNavigation(
                          context,
                          const UpdateScreen(
                            appBarTitle: "New Password",
                            formNo: 5,
                            message:
                                "Enter your new password here in order to update your current password",
                          ));
                    },
                    userFromPassword: () {
                      MHelperFunctions.simpleAnimationNavigation(
                          context,
                          const ReAuthScreen(
                            buttonText: "Verify",
                            onSubmitValueString: "password",
                            passwordFieldLabel: "Current Password",
                          ));
                    },
                  );
                },
              ),
              // -----------------Phone No---------------------
              BlocSelector<UserDetailsBloc, UserDetailsState, String>(
                selector: (state) => state.user.phoneNumber,
                builder: (context, value) {
                  return ProfileMenu(
                    title: "Phone No",
                    subtitle: value == "" ? "Click to set Phone No" : value,
                    onTap: () {
                      MHelperFunctions.simpleAnimationNavigation(
                          context,
                          const UpdateScreen(
                            formNo: 4,
                            appBarTitle: 'Update Phone Number',
                            message:
                                "Please use the phone number that is currently in use by you. This number will be used by the delivery rider to contact you regarding your order and by support for any necessary assistance.",
                          ));
                    },
                  );
                },
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              Center(
                child: TextButton(
                  onPressed: () {
                    UserController.showDeleteAccountDialog(context);
                  },
                  child: const Text('Delete Account',
                      style: TextStyle(color: MAppColors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
