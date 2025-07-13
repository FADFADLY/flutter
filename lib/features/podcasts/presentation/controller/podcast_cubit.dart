import 'package:bloc/bloc.dart';
import 'package:graduationproject/features/podcasts/domain/entity/podcast_data_entity.dart';
import 'package:meta/meta.dart';

import '../../domain/repo/podcast_repo.dart';


part 'podcast_state.dart';

class PodcastCubit extends Cubit<PodcastState> {
  final PodcastRepo podcastRepo;

  PodcastCubit({required this.podcastRepo}) : super(PodcastInitial());

  Future<void> getPodcasts() async {
    emit(PodcastLoading());

    final podcasts = await podcastRepo.getPodcasts();
    podcasts.fold(
          (failure) => emit(PodcastError(message: failure.message)),
          (response) {
            print(response.data);
        print(response.data);
        emit(PodcastLoaded(podcasts: response.data));
      },
    );
  }
}