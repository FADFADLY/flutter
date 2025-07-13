import 'package:dartz/dartz.dart';
import 'package:graduationproject/features/podcasts/domain/entity/reaction_entity.dart' show ReactionEntity;
import '../../../../core/errors/failure.dart';
import '../entity/podcast_response_entity.dart';
import '../entity/podcast_details_response_entity.dart';

abstract class PodcastRepo {
  Future<Either<Failure, PodcastResponseEntity>> getPodcasts();
  Future<Either<Failure, PodcastDetailsResponseEntity>> getPodcastDetails(String id);
  Future<Either<Failure, ReactionEntity>> toggleReaction(String id);

}