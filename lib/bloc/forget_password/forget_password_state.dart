part of 'forget_password_bloc.dart';

class ForgetPasswordState extends Equatable {
  final TextEditingController emailController;
  final GlobalKey<FormState> forgetFormKey;
  final int timeLeft;
  final bool canResend;
  ForgetPasswordState({
    GlobalKey<FormState>? forgetFormKey,
    TextEditingController? emailController,
    this.timeLeft = 60,
    this.canResend = false,
  })  : forgetFormKey = forgetFormKey ?? GlobalKey<FormState>(),
        emailController = emailController ?? TextEditingController();

  ForgetPasswordState copyWith({
    TextEditingController? emailController,
    int? timeLeft,
    bool? canResend,
  }) {
    return ForgetPasswordState(
      emailController: emailController ?? this.emailController,
      timeLeft: timeLeft ?? this.timeLeft,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object> get props =>
      [emailController, forgetFormKey, timeLeft, canResend];
}
