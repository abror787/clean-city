part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileFetchRequested extends ProfileEvent {}

class ProfileUpdateRequested extends ProfileEvent {
  final String firstName;
  final String lastName;

  const ProfileUpdateRequested({
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [firstName, lastName];
}
