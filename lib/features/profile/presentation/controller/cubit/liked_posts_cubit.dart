import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../community/domain/entity/posts_data_entity.dart';
import '../../../../community/domain/repo/repo.dart';

part 'liked_posts_state.dart';

class LikedPostsCubit extends Cubit<LikedPostsState> {
  LikedPostsCubit({required this.postsRepo}) : super(GetLikedPostsInitial());
  final PostsRepo postsRepo;

  Future<void> getPosts() async {
    emit(GetLikedPostsLoading());
    final posts = await postsRepo.getPosts();
    posts.fold(
          (failure) {
        print(failure.message);
        emit(GetLikedPostsError(message: failure.message));
      },
          (posts) {
        emit(GetLikedPostsLoaded(posts: posts.data));
      },
    );
  }
}
