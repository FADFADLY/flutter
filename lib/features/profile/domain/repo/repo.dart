import 'package:dartz/dartz.dart';
import 'dart:io'; // Added for File

import '../../../../core/errors/failure.dart';
import '../../../books/domain/entity/book_details_entity.dart';
import '../../../books/domain/entity/book_response_entity.dart';
import '../../../community/domain/entity/posts_response_entity.dart';
import '../../../podcasts/domain/entity/podcast_response_entity.dart';
import '../../data/models/update_name_model.dart';
import '../../domain/entity/profile_response_entity.dart';
import '../../domain/entity/update_bio_entity.dart';
import '../../domain/entity/update_name_entity.dart';
import '../../domain/entity/update_avatar_entity.dart'; // Added for UpdateAvatarResponseEntity
import '../../domain/entity/liked_items_response_entity.dart'; // Added for LikedItemsResponseEntity

abstract class ProfileRepo {
  Future<Either<Failure, ProfileResponseEntity>> getProfile();
  Future<Either<Failure, UpdateNameResponseEntity>> updateName(String newName);
  Future<Either<Failure, UpdateBioResponseEntity>> updateBio(String bio);
  Future<Either<Failure, UpdateAvatarResponseEntity>> updateAvatar(File avatar); // Added
  Future<Either<Failure, LikedItemsResponseEntity>> getLikedItems({required String type}); // Added
  Future<Either<Failure, PostResponseEntity>> getLikedPosts();
  Future<Either<Failure, BookResponseEntity>> getLikedBooks();

  Future<Either<Failure, PodcastResponseEntity>> getLikedPodcasts();










}