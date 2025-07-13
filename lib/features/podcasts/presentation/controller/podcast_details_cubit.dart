import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/podcast_details_data_entity.dart';
import '../../domain/repo/podcast_repo.dart';

part 'podcast_details_state.dart';

class PodcastDetailsCubit extends Cubit<PodcastDetailsState> {
  final PodcastRepo podcastRepo;
  final AudioPlayer _player = AudioPlayer();
  int _retryCount = 0;
  static const int _maxRetries = 3;

  PodcastDetailsCubit({required this.podcastRepo}) : super(PodcastDetailsInitial()) {
    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        if (state is PodcastDetailsLoaded) {
          final loadedState = state as PodcastDetailsLoaded;
          emit(PodcastDetailsLoaded(
            podcastDetails: loadedState.podcastDetails,
            playingEpisodeId: loadedState.playingEpisodeId,
            isPlaying: false,
          ));
        }
      } else if (playerState.processingState == ProcessingState.ready) {
        if (state is PodcastDetailsLoadingAudio) {
          final loadingState = state as PodcastDetailsLoadingAudio;
          emit(PodcastDetailsLoaded(
            podcastDetails: loadingState.podcastDetails,
            playingEpisodeId: loadingState.episodeId,
            isPlaying: true,
          ));
        }
      }
    }, onError: (error) {
      print('Player State Error: $error');
    });
  }

  Future<void> getPodcastDetails(String id) async {
    emit(PodcastDetailsLoading());
    final podcastDetails = await podcastRepo.getPodcastDetails(id);
    podcastDetails.fold(
          (failure) => emit(PodcastDetailsError(message: failure.message)),
          (response) {
        print('Podcast Details: $response');
        emit(PodcastDetailsLoaded(podcastDetails: response.data));
      },
    );
  }

  Future<void> togglePlayPause(String episodeId, String audioUrl) async {
    if (state is! PodcastDetailsLoaded || audioUrl.isEmpty) {
      emit(PodcastDetailsError(message: 'رابط الصوت غير صالح.'));
      return;
    }

    final currentState = state as PodcastDetailsLoaded;
    final isCurrentlyPlaying = currentState.isPlaying && currentState.playingEpisodeId == episodeId;

    try {
      // إيقاف أي بودكاست شغال لو فيه واحد تاني
      if (currentState.isPlaying && currentState.playingEpisodeId != episodeId) {
        await _player.stop();
        emit(PodcastDetailsLoaded(
          podcastDetails: currentState.podcastDetails,
          playingEpisodeId: null,
          isPlaying: false,
        ));
      }

      if (isCurrentlyPlaying) {
        await _player.pause();
        emit(PodcastDetailsLoaded(
          podcastDetails: currentState.podcastDetails,
          playingEpisodeId: episodeId,
          isPlaying: false,
        ));
      } else {
        emit(PodcastDetailsLoadingAudio(
          episodeId: episodeId,
          podcastDetails: currentState.podcastDetails,
        ));
        if (currentState.playingEpisodeId != episodeId || !_player.playing) {
          _retryCount = 0;
          await _loadAndPlayAudio(audioUrl, episodeId);
        } else {
          await _player.play();
          emit(PodcastDetailsLoaded(
            podcastDetails: currentState.podcastDetails,
            playingEpisodeId: episodeId,
            isPlaying: true,
          ));
        }
      }
    } catch (e) {
      print('Audio Error: $e');
      if (e is MissingPluginException && _retryCount < _maxRetries) {
        _retryCount++;
        await Future.delayed(Duration(seconds: 1));
        await togglePlayPause(episodeId, audioUrl);
      } else {
        emit(PodcastDetailsError(message: 'يبدو إن فيه مشكلة في التشغيل. جرب مرة تانية أو تحقق من الإنترنت.'));
      }
    }
  }

  Future<void> _loadAndPlayAudio(String audioUrl, String episodeId) async {
    try {
      await _player.setUrl(audioUrl);
      await _player.play();
      // التحديث هيتم تلقائيًا من playerStateStream
    } catch (e) {
      print('Load Error: $e');
      throw e;
    }
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}