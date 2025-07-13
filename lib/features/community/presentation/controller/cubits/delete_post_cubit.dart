import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entity/delete_post_entity.dart';
import '../../../domain/repo/repo.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit({
    required this.postsRepo,
  }) : super(DeletePostInitial());

  final PostsRepo postsRepo;

  Future<void> deletePost({required int postId}) async {
    emit(DeletePostLoading(postId: postId));
    final result = await postsRepo.deletePost(postId: postId);
    result.fold(
          (failure) {
        print(failure.message);
        emit(DeletePostError(message: failure.message, postId: postId));
      },
          (response) {
        print(response.message);
        emit(DeletePostLoaded(message: response.message, postId: postId));
      },
    );
  }
}