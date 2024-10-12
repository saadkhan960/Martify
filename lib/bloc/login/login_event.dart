part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PasswordShow extends LoginEvent {}

class RememberMe extends LoginEvent {}

class LoginFormSubmit extends LoginEvent {
  final BuildContext context;
  const LoginFormSubmit({required this.context});
  @override
  List<Object> get props => [context];
}
