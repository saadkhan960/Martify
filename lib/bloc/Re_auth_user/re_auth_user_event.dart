part of 're_auth_user_bloc.dart';

abstract class ReAuthUserEvent extends Equatable {
  const ReAuthUserEvent();

  @override
  List<Object> get props => [];
}

class HidePassword extends ReAuthUserEvent {}

class ReAuthUserSubmit extends ReAuthUserEvent {
  final BuildContext context;
  const ReAuthUserSubmit(this.context);
  @override
  List<Object> get props => [context];
}

class ReAuthUserBeforeNewEmail extends ReAuthUserEvent {
  final BuildContext context;
  const ReAuthUserBeforeNewEmail(this.context);
  @override
  List<Object> get props => [context];
}

class ReAuthUserBeforeNewPassword extends ReAuthUserEvent {
  final BuildContext context;
  const ReAuthUserBeforeNewPassword(this.context);
  @override
  List<Object> get props => [context];
}
