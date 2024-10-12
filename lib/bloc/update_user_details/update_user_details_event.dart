part of 'update_user_details_bloc.dart';

abstract class UpdateUserDetailsEvent extends Equatable {
  const UpdateUserDetailsEvent();

  @override
  List<Object> get props => [];
}

class UpdateFullName extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdateFullName({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdateUsername extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdateUsername({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdateEmail extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdateEmail({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdatePassword extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdatePassword({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdatePhoneNo extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdatePhoneNo({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdateGender extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdateGender({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdateDOB extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdateDOB({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdateProfilepicture extends UpdateUserDetailsEvent {
  final BuildContext context;
  const UpdateProfilepicture({required this.context});
  @override
  List<Object> get props => [context];
}

class HidePassword extends UpdateUserDetailsEvent {}
