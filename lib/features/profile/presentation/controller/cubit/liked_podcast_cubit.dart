import 'package:bloc/bloc.dart';
import 'package:graduationproject/features/podcasts/domain/entity/podcast_data_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/repo/repo.dart';



part 'liked_podcast_state.dart';

class LikedPodcastsCubit extends Cubit<LikedPodcastState> {
  final ProfileRepo profileRepo;

  LikedPodcastsCubit({required this.profileRepo}) : super(LikedPodcastInitial());

  Future<void> getLikedPodcasts() async {
    emit(LikedPodcastLoading());

    final podcasts = await profileRepo.getLikedPodcasts();
    podcasts.fold(
          (failure) => emit(LikedPodcastError(message: failure.message)),
          (response) {
            print(response.data);
        print(response.data);
        emit(LikedPodcastLoaded(podcasts: response.data));
      },
    );
  }
}