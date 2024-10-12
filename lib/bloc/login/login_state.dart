part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool hidePassword;
  final bool rememberMe;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> loginFormKey;

  LoginState({
    this.rememberMe = false,
    this.hidePassword = true,
    GlobalKey<FormState>? loginFormKey,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  })  : loginFormKey = loginFormKey ?? GlobalKey<FormState>(),
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  LoginState copyWith({
    bool? rememberMe,
    bool? hidePassword,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  }) {
    return LoginState(
      rememberMe: rememberMe ?? this.rememberMe,
      hidePassword: hidePassword ?? this.hidePassword,
      loginFormKey: loginFormKey,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }

  @override
  List<Object> get props => [
        hidePassword,
        emailController,
        passwordController,
        loginFormKey,
        rememberMe
      ];
}
