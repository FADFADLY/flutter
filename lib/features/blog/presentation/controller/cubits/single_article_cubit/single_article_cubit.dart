import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entity/single_article/single_article.dart';
import '../../../../domain/repo/repo.dart';

part 'single_article_state.dart';

class SingleArticleCubit extends Cubit<SingleArticleState> {
  SingleArticleCubit({required this.blogRepo}) : super(SingleArticleInitial());
  final BlogRepo blogRepo;

  Future<void> getSingleArticle(int id) async {
    emit(SingleArticleLoading());

      final singleArticle = await blogRepo.getSingleArticle(id);
      singleArticle.fold(
        (failure) => emit(SingleArticleError(message: failure.message)),
        (article) => emit(SingleArticleLoaded(article: article.data!)),
      );

  }


}
