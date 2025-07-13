import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/community/domain/entity/store_post_response_entity.dart';
import '../entity/comment_entity.dart';
import '../entity/delete_comment_entity.dart';
import '../entity/get_comments_entity.dart';
import '../entity/posts_response_entity.dart';
import '../entity/reaction_entity.dart';
import '../entity/update_comment_response_entity.dart';
import '../entity/update_post_entity.dart';
import '../entity/vote_response_entity.dart';
import '../entity/store_comment_response_entity.dart';
import '../entity/delete_post_entity.dart';

abstract class PostsRepo {
  Future<Either<Failure, StorePostEntity>> storePost({required String content});
  Future<Either<Failure, StorePostEntity>> storePostWithImage({required File image, required String content});
  Future<Either<Failure, StorePostEntity>> storePostWithFile({required File file, required String content});
  Future<Either<Failure, StorePostEntity>> storePostWithAudio({required File audio, required String content});
  Future<Either<Failure, StorePostEntity>> storePostWithPoll({required String content, required List<String> options});


  Future<Either<Failure, PostResponseEntity>> getPosts();
  Future<Either<Failure, PostReactionEntity>> reaction({required int postId, required String type});
  Future<Either<Failure, VoteResponseEntity>> voteOnPost({required int postId, required int optionId});
  Future<Either<Failure, StoreCommentResponseEntity>> storeComment({required int postId, required String commentContent});
  Future<Either<Failure, GetCommentsEntity>> getComments({required int postId});
  Future<Either<Failure, DeletePostEntity>> deletePost({required int postId});
  Future<Either<Failure, UpdateCommentResponseEntity>> updateComment({required int commentId, required String commentContent});
  Future<Either<Failure, DeleteCommentEntity>> deleteComment({required int commentId});
  Future<Either<Failure, UpdatePostEntity>> updatePost({required int postId, required String content});
}