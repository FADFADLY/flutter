import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/errors/failure.dart';
import 'package:graduationproject/features/community/domain/repo/repo.dart';
import 'package:meta/meta.dart';

part 'update_comment_state.dart';

class UpdateCommentCubit extends Cubit<UpdateCommentState> {
  UpdateCommentCubit({required this.postsRepo}) : super(UpdateCommentInitial());

  final PostsRepo postsRepo;

  Future<void> updateComment({required int commentId, required String commentContent}) async {
    emit(UpdateCommentLoading(commentId: commentId));
    final result = await postsRepo.updateComment(commentId: commentId, commentContent: commentContent);
    result.fold(
      (failure) {
        print(failure.message);
        emit(UpdateCommentError(message: failure.message, commentId: commentId));
      },
      (response) {
        print(response.message);
        emit(UpdateCommentLoaded(message: response.message, commentId: commentId));
      },
    );
  }
}