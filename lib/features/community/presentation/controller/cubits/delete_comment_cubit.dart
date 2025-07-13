import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/delete_comment_entity.dart';
import '../../../domain/repo/repo.dart';
part 'delete_comment_state.dart';

class DeleteCommentCubit extends Cubit<DeleteCommentState> {
  final PostsRepo postsRepo;

  DeleteCommentCubit({required this.postsRepo}) : super(DeleteCommentInitial());

  Future<void> deleteComment({required int commentId}) async {
    emit(DeleteCommentLoading(commentId: commentId));
    final result = await postsRepo.deleteComment(commentId: commentId);
    result.fold(
      (failure) => emit(DeleteCommentError(message: failure.message, commentId: commentId)),
      (response) => emit(DeleteCommentLoaded(response: response, commentId: commentId)),
    );
  }
}