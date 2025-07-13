import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entity/vote_response_entity.dart';
import '../../../domain/repo/repo.dart';

part 'vote_state.dart';

class VoteCubit extends Cubit<VoteState> {
  VoteCubit({
    required this.postsRepo,
  }) : super(VoteInitial());

  final PostsRepo postsRepo;

  Future<void> vote({required int postId, required int optionId}) async {
    emit(VoteLoading(postId: postId, optionId: optionId));
    final result = await postsRepo.voteOnPost(postId: postId, optionId: optionId);
    result.fold(
          (failure) {
        print(failure.message);
        emit(VoteError(message: failure.message, postId: postId, optionId: optionId));
      },
          (response) {
        print(response.message);
        emit(VoteLoaded(message: response.message, postId: postId, optionId: optionId));
      },
    );
  }
}