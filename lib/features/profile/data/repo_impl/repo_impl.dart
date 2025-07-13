import 'package:dartz/dartz.dart';
import 'package:graduationproject/core/services/remote/posts.dart';
import 'dart:io';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/remote/profile.dart';
import '../../../books/domain/entity/book_response_entity.dart';
import '../../../community/domain/entity/posts_response_entity.dart';
import '../../../podcasts/domain/entity/podcast_response_entity.dart';
import '../../domain/entity/profile_response_entity.dart';
import '../../domain/entity/update_bio_entity.dart';
import '../../domain/entity/update_name_entity.dart';
import '../../domain/entity/update_avatar_entity.dart';
import '../../domain/entity/liked_items_response_entity.dart';
import '../../domain/repo/repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileService profileService;

  ProfileRepoImpl({required this.profileService});

  @override
  Future<Either<Failure, ProfileResponseEntity>> getProfile() async {
    try {
      final response = await profileService.getProfile();
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getProfile: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to process profile data: ${e.toString()}",
      ));
    }
  }

  @override
  Future<Either<Failure, UpdateNameResponseEntity>> updateName(String newName) async {
    try {
      final response = await profileService.updateName(newName);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in updateName: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to update name: ${e.toString()}",
      ));
    }
  }

  @override
  Future<Either<Failure, UpdateBioResponseEntity>> updateBio(String bio) async {
    try {
      final response = await profileService.updateBio(bio);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in updateBio: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to update bio: ${e.toString()}",
      ));
    }
  }

  @override
  Future<Either<Failure, UpdateAvatarResponseEntity>> updateAvatar(File avatar) async {
    try {
      final response = await profileService.updateAvatar(avatar);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in updateAvatar: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to update avatar: ${e.toString()}",
      ));
    }
  }
  Future<Either<Failure, PostResponseEntity>> getLikedPosts(
      ) async {
    try {
      final response = await profileService.getLikedPosts(

      );
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
  Future<Either<Failure, LikedItemsResponseEntity>> getLikedItems(
      {required String type}
      ) async {
    try {
      final response = await profileService.getLikedItems(type: type);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getLikedItems: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to fetch liked items: ${e.toString()}",
      ));
    }
  }
  Future<Either<Failure, BookResponseEntity>> getLikedBooks() async {
    try {
      final response = await profileService.getLikedBooks();
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
      print("Error in getBooks: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process books data: ${e.toString()}"));
    }
  }
  Future<Either<Failure, PodcastResponseEntity>> getLikedPodcasts() async {
    try {
      final response = await profileService.getLikedPodcasts();
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getPodcasts: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to process podcasts data: ${e.toString()}",
      ));
    }
  }

}