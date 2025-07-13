import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entity/store_comment_response_entity.dart';
import '../../../domain/repo/repo.dart';

part 'store_comment_state.dart';

class StoreCommentCubit extends Cubit<StoreCommentState> {
  StoreCommentCubit({
    required this.postsRepo,
  }) : super(CommentInitial());

  final PostsRepo postsRepo;

  Future<void> storeComment({required int postId, required String commentContent}) async {
    emit(CommentLoading(postId: postId, commentContent: commentContent));
    final result = await postsRepo.storeComment(postId: postId, commentContent: commentContent);
    result.fold(
      (failure) {
        print(failure.message);
        emit(CommentError(message: failure.message, postId: postId, commentContent: commentContent));
      },
      (response) {
        print(response.message);
        emit(CommentLoaded(message: response.message, postId: postId, commentContent: commentContent));
      },
    );
  }
}