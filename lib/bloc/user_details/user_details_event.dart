part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserDetailsEvent {
  final BuildContext context;
  const FetchUser({required this.context});
  @override
  List<Object> get props => [context];
}

class UpdateUser extends UserDetailsEvent {
  final UserModel updatedUser;

  const UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}

class Chagneimagestatus extends UserDetailsEvent {
  final bool value;

  const Chagneimagestatus(this.value);

  @override
  List<Object> get props => [value];
}

class Fetchuserdetialsbool extends UserDetailsEvent {
  final BuildContext context;
  const Fetchuserdetialsbool({required this.context});
  @override
  List<Object> get props => [context];
}
