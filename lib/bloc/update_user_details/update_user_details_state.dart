part of 'update_user_details_bloc.dart';

class UpdateUserDetailsState extends Equatable {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNoController;
  final TextEditingController genderController;
  final TextEditingController dateOfBirthController;
  final GlobalKey<FormState> updateUserFormKey;
  final bool hidePassword;

  UpdateUserDetailsState({
    this.hidePassword = true,
    TextEditingController? passwordController,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? userNameController,
    TextEditingController? emailController,
    TextEditingController? phoneNoController,
    TextEditingController? genderController,
    TextEditingController? dateOfBirthController,
    GlobalKey<FormState>? updateUserFormKey,
  })  : firstNameController = firstNameController ?? TextEditingController(),
        lastNameController = lastNameController ?? TextEditingController(),
        userNameController = userNameController ?? TextEditingController(),
        emailController = emailController ?? TextEditingController(),
        phoneNoController = phoneNoController ?? TextEditingController(),
        genderController = genderController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController(),
        dateOfBirthController =
            dateOfBirthController ?? TextEditingController(),
        updateUserFormKey = updateUserFormKey ?? GlobalKey<FormState>();

  UpdateUserDetailsState copyWith(
      {TextEditingController? firstNameController,
      bool? hidePassword,
      TextEditingController? lastNameController,
      TextEditingController? userNameController,
      TextEditingController? emailController,
      TextEditingController? phoneNoController,
      TextEditingController? genderController,
      TextEditingController? dateOfBirthController,
      TextEditingController? passwordController}) {
    return UpdateUserDetailsState(
      hidePassword: hidePassword ?? this.hidePassword,
      passwordController: passwordController ?? this.passwordController,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      userNameController: userNameController ?? this.userNameController,
      emailController: emailController ?? this.emailController,
      phoneNoController: phoneNoController ?? this.phoneNoController,
      genderController: genderController ?? this.genderController,
      dateOfBirthController:
          dateOfBirthController ?? this.dateOfBirthController,
      updateUserFormKey: updateUserFormKey,
    );
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    genderController.dispose();
    dateOfBirthController.dispose();
    passwordController.dispose();
  }

  @override
  List<Object> get props => [
        firstNameController,
        lastNameController,
        userNameController,
        emailController,
        phoneNoController,
        genderController,
        dateOfBirthController,
        passwordController,
        updateUserFormKey,
        hidePassword,
      ];

  get signUpFormKey => null;
}
