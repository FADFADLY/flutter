import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

import '../../../../../domain/entity/mood_entry_entity.dart';
import '../../../../../domain/repo/repo.dart';

part 'mood_tracker_state.dart';

class MoodTrackerCubit extends Cubit<MoodTrackerState> {
  MoodTrackerCubit({required this.moodTrackerRepo})
      : super(MoodTrackerInitial());

  final MoodTrackerRepo moodTrackerRepo;
  final TextEditingController whatYouFeelController = TextEditingController();
  final TextEditingController whatHappenedController = TextEditingController();
  final List<String> emojis = [
    '\u{1F610}', // 😐 none
    '\u{1F620}', // 😠 anger
    '\u{1F604}', // 😄 joy
    '\u{1F622}', // 😢 sadness
    '\u{2764}',  // ❤️ love
    '\u{1F628}', // 😨 fear
    '\u{1F917}', // 🤗 sympathy
    '\u{1F632}', // 😲 surprise
  ];


  int currentMoodIndex = -1; // Start with -1 to indicate no mood selected
  String mood = '';
  final formKey = GlobalKey<FormState>();

  Future<void> postMood() async {

    emit(MoodTrackerPostLoading());

    final result = await moodTrackerRepo.createMoodEntry(

      notes: whatHappenedController.text,
    );

    result.fold(
          (failure) => emit(MoodTrackerPostError(message: failure.message)),
          (response) => emit(MoodTrackerPostSuccess(moodEntryEntity: response)),
    );
  }

  void updateMood(int moodIndex) {
    currentMoodIndex = moodIndex;
    selectedEmoticon();
    emit(MoodTrackerUpdateEmotion());
  }

  String selectedEmoticon() {
    if (currentMoodIndex < 0 || currentMoodIndex >= emojis.length) {
      mood = 'neutral';
      return mood;
    }
    switch (emojis[currentMoodIndex]) {
      case '\u{1F604}':
        mood = 'happy';
        break;
      case '\u{1F610}':
        mood = 'neutral';
        break;
      case '\u{1F614}':
        mood = 'sad';
        break;
      case '\u{1F621}':
        mood = 'angry';
        break;
      case '\u{1F622}':
        mood = 'crying';
        break;
      default:
        mood = 'neutral';
    }
    return mood;
  }

  @override
  Future<void> close() {
    whatYouFeelController.dispose();
    whatHappenedController.dispose();
    return super.close();
  }
}