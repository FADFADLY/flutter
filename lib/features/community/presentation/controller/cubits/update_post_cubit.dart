import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/update_post_entity.dart';
import '../../../domain/repo/repo.dart';
part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  final PostsRepo postsRepo;

  UpdatePostCubit({required this.postsRepo}) : super(UpdatePostInitial());

  Future<void> updatePost({required int postId, required String content}) async {
    emit(UpdatePostLoading(postId: postId));
    final result = await postsRepo.updatePost(postId: postId, content: content);
    result.fold(
      (failure) => emit(UpdatePostError(message: failure.message, postId: postId)),
      (response) => emit(UpdatePostLoaded(response: response, postId: postId)),
    );
  }
}