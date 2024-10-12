part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

//When Form Submit
class SignUpPress extends SignUpEvent {
  final BuildContext context;
  const SignUpPress({required this.context});
  @override
  List<Object> get props => [context];
}

//Show Passwords Obscure
class PasswordShow extends SignUpEvent {}

class ConfirmPasswordShow extends SignUpEvent {}

class PrivacyPolicyCheck extends SignUpEvent {
  final bool value;
  const PrivacyPolicyCheck({required this.value});
  @override
  List<Object> get props => [value];
}

class StartTimer extends SignUpEvent {}

class TickTimer extends SignUpEvent {}
