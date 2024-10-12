part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgetPassword extends ForgetPasswordEvent {
  final BuildContext context;
  const ForgetPassword({required this.context});
  @override
  List<Object> get props => [context];
}

class StartTimer extends ForgetPasswordEvent {}

class TickTimer extends ForgetPasswordEvent {}
