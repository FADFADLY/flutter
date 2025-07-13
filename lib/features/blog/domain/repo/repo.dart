import 'package:dartz/dartz.dart';
import 'package:graduationproject/features/blog/domain/entity/single_article/single_article_response.dart';

import '../../../../core/errors/failure.dart';
import '../entity/blog_reaction/blog_reaction_response_entity.dart';
import '../entity/full_blog/article_entity.dart';
import '../entity/full_blog/blog_response_entity.dart';

abstract class BlogRepo {
  Future<Either<Failure, BlogResponseEntity>> getArticles();
  Future<Either<Failure, SingleArticleResponse>> getSingleArticle(int id);
  Future<Either<Failure, BlogReactionResponseEntity>> postReaction({required int id});
}