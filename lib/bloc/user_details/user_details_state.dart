part of 'user_details_bloc.dart';

class UserDetailsState extends Equatable {
  final UserModel user;
  final bool profileLoading;
  final String errorMessage;
  final bool imageUploading;
  final bool fetchuserbool;

  // Constructor with UserModel.empty() as the default for user
  UserDetailsState({
    this.fetchuserbool = true,
    this.imageUploading = false,
    UserModel? user,
    this.profileLoading = false,
    this.errorMessage = '',
  }) : user = user ?? UserModel.empty();

  UserDetailsState copyWith(
      {UserModel? user,
      bool? fetchuserbool,
      bool? profileLoading,
      String? errorMessage,
      bool? imageUploading}) {
    return UserDetailsState(
        imageUploading: imageUploading ?? this.imageUploading,
        user: user ?? this.user,
        profileLoading: profileLoading ?? this.profileLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        fetchuserbool: fetchuserbool ?? this.fetchuserbool);
  }

  @override
  List<Object?> get props =>
      [user, profileLoading, errorMessage, imageUploading, fetchuserbool];
}
