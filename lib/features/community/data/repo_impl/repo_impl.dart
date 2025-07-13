import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:graduationproject/core/errors/failure.dart';
import 'package:graduationproject/core/errors/exceptions.dart';
import 'package:graduationproject/core/services/remote/posts.dart';
import 'package:graduationproject/features/community/domain/entity/posts_response_entity.dart';
import 'package:graduationproject/features/community/domain/entity/store_post_response_entity.dart';
import 'package:graduationproject/features/community/domain/entity/vote_response_entity.dart';
import 'package:graduationproject/features/community/domain/entity/store_comment_response_entity.dart';
import 'package:graduationproject/features/community/domain/entity/delete_post_entity.dart';
import 'package:graduationproject/features/podcasts/domain/entity/reaction_entity.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/delete_comment_entity.dart';
import '../../domain/entity/get_comments_entity.dart';
import '../../domain/entity/reaction_entity.dart';
import '../../domain/entity/update_comment_response_entity.dart';
import '../../domain/entity/update_post_entity.dart';
import '../../domain/repo/repo.dart';

class PostsRepoImpl extends PostsRepo {
  final PostsService postsService;

  PostsRepoImpl({required this.postsService});

  @override
  Future<Either<Failure, StorePostEntity>> storePost({required String content}) async {
    try {
      final response = await postsService.storePost(content: content);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in storePost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to store post: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, StorePostEntity>> storePostWithImage({required String content, required File image}) async {
    try {
      final response = await postsService.storePostWithImage(image: image, content: content);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in storePost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to store post: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, StorePostEntity>> storePostWithFile({required String content, required File file}) async {
    try {
      final response = await postsService.storePostWithFile(file: file, content: content);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in storePost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to store post: ${e.toString()}"));
    }
  }  @override
  Future<Either<Failure, StorePostEntity>> storePostWithAudio({required String content, required File audio}) async {
    try {
      final response = await postsService.storePostWithFile(file: audio, content: content);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in storePost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to store post: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, StorePostEntity>> storePostWithPoll({required String content, required List<String> options}) async {
    try {
      final response = await postsService.storePostWithPoll(options: options, content: content);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in storePost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to store post: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, PostResponseEntity>> getPosts() async {
    try {
      final response = await postsService.getPosts();
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getPosts: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to get posts: ${e.toString()}"));
    }
  }

  @override


  @override
  Future<Either<Failure, PostReactionEntity>> reaction({required int postId, required String type}) async {
    try {
      final response = await postsService.reaction(postId: postId, type: type);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in toggleReaction: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to toggle reaction: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, VoteResponseEntity>> voteOnPost({required int postId, required int optionId}) async {
    try {
      final response = await postsService.voteOnPost(postId: postId, optionId: optionId);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in voteOnPost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to vote: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, StoreCommentResponseEntity>> storeComment({required int postId, required String commentContent}) async {
    try {
      final response = await postsService.storeComment(postId: postId, commentContent: commentContent);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in storeComment: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to store comment: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, GetCommentsEntity>> getComments({required int postId}) async {
    try {
      final response = await postsService.getComments(postId: postId);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getComments: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to get comments: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, DeletePostEntity>> deletePost({required int postId}) async {
    try {
      final response = await postsService.deletePost(postId: postId);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in deletePost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to delete post: ${e.toString()}"));
    }
  }  Future<Either<Failure, UpdateCommentResponseEntity>> updateComment({required int commentId, required String commentContent}) async {
    try {
      final response = await postsService.updateComment(commentId: commentId, commentContent: commentContent);
      if (response.success) {
        return Right(UpdateCommentResponseEntity(
          success: response.success,
          message: response.message,
          data: response.data,
          errors: response.errors,
          code: response.code,
        ));
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in updateComment: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to update comment: ${e.toString()}"));
    }
  }
  Future<Either<Failure, DeleteCommentEntity>> deleteComment({required int commentId}) async {
    try {
      final response = await postsService.deleteComment(commentId: commentId);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in deleteComment: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to delete comment: ${e.toString()}"));
    }
  }
  Future<Either<Failure, UpdatePostEntity>> updatePost({required int postId, required String content}) async {
    try {
      final response = await postsService.updatePost(postId: postId, content: content);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in updatePost: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to update post: ${e.toString()}"));
    }
  }
}