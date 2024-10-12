part of 're_auth_user_bloc.dart';

class ReAuthUserState extends Equatable {
  final bool hidePassword;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> reAuthUserFormKey;

  ReAuthUserState({
    this.hidePassword = true,
    GlobalKey<FormState>? reAuthUserFormKey,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  })  : reAuthUserFormKey = reAuthUserFormKey ?? GlobalKey<FormState>(),
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  ReAuthUserState copyWith({
    bool? hidePassword,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return ReAuthUserState(
      hidePassword: hidePassword ?? this.hidePassword,
      reAuthUserFormKey: reAuthUserFormKey,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }

  @override
  List<Object> get props => [
        hidePassword,
        emailController,
        passwordController,
        reAuthUserFormKey,
      ];
}
