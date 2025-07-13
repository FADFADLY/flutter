import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../../domain/entity/posts_data_entity.dart';
import '../../../domain/repo/repo.dart';

part 'reaction_state.dart';

class ReactionsCubit extends Cubit<PostsReactionState> {
  ReactionsCubit({
    required this.postsRepo,
  }) : super(PostsReactionInitial());

  final PostsRepo postsRepo;

  Future<void> reaction({required int postId, required String type}) async {
    emit(PostsReactionLoading(postId: postId));
    final result = await postsRepo.reaction(postId: postId, type: type);
    result.fold(
          (failure) {
        print(failure.message);
        emit(PostsReactionError(message: failure.message, postId: postId));
      },
          (response) {
        print(response.message);
        emit(PostsReactionLoaded(message: response.message, postId: postId));
      },
    );
  }
}