part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserProfile? profile;
  final String? errorMessage;

  const ProfileState._({
    this.status = ProfileStatus.initial,
    this.profile,
    this.errorMessage,
  });

  const ProfileState.initial() : this._();

  const ProfileState.loading() : this._(status: ProfileStatus.loading);

  const ProfileState.success(UserProfile profile)
      : this._(status: ProfileStatus.success, profile: profile);

  const ProfileState.error(String message)
      : this._(status: ProfileStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [status, profile, errorMessage];
}
