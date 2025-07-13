import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/errors/failure.dart';
import '../../../domain/entity/comment_entity.dart';
import '../../../domain/entity/get_comments_entity.dart';
import '../../../domain/repo/repo.dart';

part 'get_comments_state.dart';

class GetCommentsCubit extends Cubit<CommentsState> {
  final PostsRepo postsRepo;

  GetCommentsCubit({required this.postsRepo}) : super(CommentsInitial());

  Future<void> getComments(int postId) async {
    emit(CommentsLoading(postId: postId));
    final result = await postsRepo.getComments(postId: postId);
    result.fold(
          (failure) => emit(CommentsError(message: failure.message, postId: postId)),
          (response) => emit(CommentsLoaded(response: response, postId: postId)),
    );
  }

  void updateCommentReaction({
    required int postId,
    required int commentId,
    required bool reacted,
    required int reactionsCount,
  }) {
    if (state is CommentsLoaded) {
      final currentState = state as CommentsLoaded;
      final updatedComments = currentState.response.data.map((comment) {
        if (comment.id == commentId) {
          return CommentEntity(
            id: comment.id,
            body: comment.body,
            postId: comment.postId,
            createdAt: comment.createdAt,
            reactionsCount: reactionsCount,
            reacted: reacted,
            user: comment.user,
          );
        }
        return comment;
      }).toList();

      emit(CommentsLoaded(
        response: GetCommentsEntity(
          success: currentState.response.success,
          message: currentState.response.message,
          data: updatedComments,
          errors: currentState.response.errors,
          code: currentState.response.code,
        ),
        postId: postId,
      ));
    }
  }
}