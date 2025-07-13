import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/services/remote/blog.dart';
import '../../../../domain/entity/blog_reaction/blog_reaction_response_entity.dart';
import '../../../../domain/repo/repo.dart';

part 'blog_reaction_state.dart';

class BlogReactionCubit extends Cubit<BlogReactionState> {
  BlogReactionCubit({required this.blogRepo}) : super(BlogReactionInitial());

  final BlogRepo blogRepo;

  bool isLiked = false;
  int likeCount = 0;

  // دالة لتهيئة القيم بناءً على القيم اللي جاية من الـ SingleArticle
  void initializeReaction({required bool reacted, required int likes}) {
    isLiked = reacted; // القيمة اللي جاية من الـ backend
    likeCount = likes; // عدد اللايكات اللي جاي من الـ backend
    emit(BlogReactionInitial()); // نحدث الـ state
  }

  Future<void> toggleReaction({required int id}) async {
    emit(BlogReactionLoading());

    final result = await blogRepo.postReaction(id: id);

    result.fold(
          (l) => emit(BlogReactionError(message: l.message)),
          (r) {
        // بنعكس حالة الـ like بناءً على الضغطة
        isLiked = !isLiked;
        // بنحدث عدد اللايكات بناءً على الـ isLiked
        likeCount = isLiked ? likeCount + 1 : likeCount - 1;
        emit(BlogReactionSuccess(data: r));
      },
    );
  }
}