import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/network/profile/profile_repository.dart';
import '../../../core/network/auth/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final AuthRepository authRepository;

  ProfileBloc({
    required this.profileRepository,
    required this.authRepository,
  }) : super(const ProfileState.initial()) {
    on<ProfileFetchRequested>(_onFetchRequested);
    on<ProfileUpdateRequested>(_onUpdateRequested);
  }

  Future<void> _onFetchRequested(ProfileFetchRequested event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());
    try {
      final userIdStr = await authRepository.getUserId();
      if (userIdStr == null) throw Exception('User not logged in');
      
      final profile = await profileRepository.getProfile(int.parse(userIdStr));
      emit(ProfileState.success(profile));
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }

  Future<void> _onUpdateRequested(ProfileUpdateRequested event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());
    try {
      final userIdStr = await authRepository.getUserId();
      if (userIdStr == null) throw Exception('User not logged in');
      
      final updatedProfile = await profileRepository.updateProfile(
        int.parse(userIdStr),
        event.firstName,
        event.lastName,
      );
      emit(ProfileState.success(updatedProfile));
    } catch (e) {
      emit(ProfileState.error(e.toString()));
    }
  }
}
