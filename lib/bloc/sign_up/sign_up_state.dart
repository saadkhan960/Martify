part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final bool hidePassword;
  final bool hideConfirmPassword;
  final bool privacyPolicy;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNoController;
  final GlobalKey<FormState> signUpFormKey;
  final int timeLeft;
  final bool canResend;

  SignUpState({
    this.timeLeft = 60,
    this.canResend = false,
    this.hidePassword = true,
    this.privacyPolicy = false,
    this.hideConfirmPassword = true,
    GlobalKey<FormState>? signUpFormKey,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? userNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? phoneNoController,
  })  : signUpFormKey = signUpFormKey ?? GlobalKey<FormState>(),
        firstNameController = firstNameController ?? TextEditingController(),
        lastNameController = lastNameController ?? TextEditingController(),
        userNameController = userNameController ?? TextEditingController(),
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController(),
        phoneNoController = phoneNoController ?? TextEditingController();

  SignUpState copyWith({
    int? timeLeft,
    bool? canResend,
    bool? privacyPolicy,
    bool? hidePassword,
    bool? hideConfirmPassword,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? userNameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? phoneNoController,
  }) {
    return SignUpState(
      timeLeft: timeLeft ?? this.timeLeft,
      canResend: canResend ?? this.canResend,
      hideConfirmPassword: hideConfirmPassword ?? this.hideConfirmPassword,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      hidePassword: hidePassword ?? this.hidePassword,
      signUpFormKey: signUpFormKey,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      userNameController: userNameController ?? this.userNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      phoneNoController: phoneNoController ?? this.phoneNoController,
    );
  }

  @override
  List<Object?> get props => [
        firstNameController.text,
        lastNameController.text,
        userNameController.text,
        emailController.text,
        passwordController.text,
        phoneNoController.text,
        signUpFormKey,
        hidePassword,
        privacyPolicy,
        hideConfirmPassword,
        timeLeft,
        canResend
      ];
}
