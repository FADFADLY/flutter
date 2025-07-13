import 'package:dartz/dartz.dart';

import 'package:graduationproject/core/errors/failure.dart';
import 'package:graduationproject/core/services/remote/blog.dart';
import 'package:graduationproject/features/blog/domain/entity/blog_reaction/blog_reaction_response_entity.dart';
import 'package:graduationproject/features/blog/domain/entity/single_article/single_article_response.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entity/full_blog/blog_response_entity.dart';
import '../../domain/repo/repo.dart';

class BlogRepoImpl extends BlogRepo {
  final BlogService blogService;

  BlogRepoImpl({required this.blogService});

  @override
  Future<Either<Failure, BlogResponseEntity>> getArticles() async {
    try {
      final response = await blogService.getAllBlogs();
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getNotes: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process notes data: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, SingleArticleResponse>> getSingleArticle(
      int id) async {
    try {
      final response = await blogService.getSingleBlog(id);
      if (response.success) {
        return Right(response);
      } else {
        return Left(
          ServerFailure(message: response.message, statusCode: response.code),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getNotes: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process notes data: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, BlogReactionResponseEntity>> postReaction({required int id})async {
    try {
      final response =await blogService.postReaction(id: id);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getNotes: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process notes data: ${e.toString()}"));
    }
  }
}
