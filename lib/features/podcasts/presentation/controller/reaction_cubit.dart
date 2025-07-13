import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/reaction_entity.dart';
import '../../domain/repo/podcast_repo.dart';

part 'reaction_state.dart';

class ReactionCubit extends Cubit<ReactionState> {
  final PodcastRepo reactionRepo;

  ReactionCubit({required this.reactionRepo}) : super(ReactionInitial());

  Future<void> toggleReaction(String id) async {
    emit(ReactionLoading());

    final reaction = await reactionRepo.toggleReaction(id);
    reaction.fold(
          (failure) => emit(ReactionError(message: failure.message)),
          (response) {
        print(response.message);
        emit(ReactionLoaded(response: response));
      },
    );
  }
}