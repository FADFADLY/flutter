import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:io'; // Added for File

import '../../../../../config/cache/secure_cache_helper.dart';
import '../../../domain/entity/liked_items_response_entity.dart';
import '../../../domain/repo/repo.dart';

part 'liked_items_state.dart';

class LikedItemsCubit extends Cubit<LikedItemsState> {
  final ProfileRepo profileRepo;

  LikedItemsCubit({required this.profileRepo}) : super(LikedItemsInitial());

  Future<void> fetchLikedItems(
  {
    required String type,
}
      ) async {
    emit(LikedItemsLoading());

    final result = await profileRepo.getLikedItems(
        type: type
    );
    result.fold(
      (failure) => emit(LikedItemsError(message: failure.message)),
      (response) async {
        print(response.data);
        emit(LikedItemsLoaded(likedItems: response));
      },
    );
  }
}