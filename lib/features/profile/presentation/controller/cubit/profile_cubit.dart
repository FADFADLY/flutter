import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:io'; // Added for File

import '../../../../../config/cache/secure_cache_helper.dart';
import '../../../domain/entity/profile_data_entity.dart';
import '../../../domain/repo/repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());

    final profile = await profileRepo.getProfile();
    profile.fold(
          (failure) => emit(ProfileError(message: failure.message)),
          (response) async {
        print(response.data);
        await SecureCacheHelper.set(key:"user_name", value: response.data.username!);
        log("//////////////////////////${response.data.username!}");
print(response.data.username);
        emit(ProfileLoaded(profile: response.data));
      },
    );
  }

  Future<void> updateName(String newName) async {
    emit(ProfileLoading());

    final result = await profileRepo.updateName(newName);
    result.fold(
          (failure) => emit(ProfileError(message: failure.message)),
          (response) async {
        getProfile(); // Refresh profile after update
      },
    );
  }

  Future<void> updateBio(String bio) async {
    emit(ProfileLoading());

    final result = await profileRepo.updateBio(bio);
    result.fold(
          (failure) => emit(ProfileError(message: failure.message)),
          (response) {
        getProfile(); // Refresh profile after update
      },
    );
  }

  Future<void> updateAvatar(File avatar) async {
    emit(ProfileLoading());

    final result = await profileRepo.updateAvatar(avatar);
    result.fold(
          (failure) => emit(ProfileError(message: failure.message)),
          (response) {
        getProfile(); // Refresh profile after update
      },
    );
  }
}