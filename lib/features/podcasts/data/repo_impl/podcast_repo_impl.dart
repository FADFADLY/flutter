import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/remote/podcast_service.dart';
import '../../domain/entity/podcast_response_entity.dart';
import '../../domain/entity/podcast_details_response_entity.dart';
import '../../domain/entity/reaction_entity.dart';
import '../../domain/repo/podcast_repo.dart';

class PodcastRepoImpl extends PodcastRepo {
  final PodcastService podcastService;

  PodcastRepoImpl({required this.podcastService});

  @override
  Future<Either<Failure, PodcastResponseEntity>> getPodcasts() async {
    try {
      final response = await podcastService.getAllPodcasts();
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
  @override
  Future<Either<Failure, ReactionEntity>> toggleReaction(String id) async {
    try {
      final response = await podcastService.toggleReaction(id);
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
      print("Error in toggleReaction: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to toggle reaction: ${e.toString()}",
      ));
    }
  }
  @override
  Future<Either<Failure, PodcastDetailsResponseEntity>> getPodcastDetails(String id) async {
    try {
      final response = await podcastService.getPodcastDetails(id);
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
      print("Error in getPodcastDetails: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to process podcast details: ${e.toString()}",
      ));
    }
  }
}