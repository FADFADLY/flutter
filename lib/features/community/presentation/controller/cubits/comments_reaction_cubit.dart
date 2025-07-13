import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/repo/repo.dart';

part 'comments_reaction_state.dart';

class CommentsReactionCubit extends Cubit<CommentsReactionState> {
  CommentsReactionCubit({required this.postsRepo}) : super(CommentsReactionInitial());

  final PostsRepo postsRepo;

  Future<void> reaction({required int commentId, required String type}) async {
    emit(CommentsReactionLoading(commentId: commentId));
    final result = await postsRepo.reaction(postId: commentId, type: type);
    result.fold(
          (failure) {
        print(failure.message);
        emit(CommentsReactionError(message: failure.message, commentId: commentId));
      },
          (response) {
        print(response.message);
        emit(CommentsReactionLoaded(message: response.message, commentId: commentId));
      },
    );
  }
}