import 'package:graduationproject/features/profile/domain/entity/liked_item_entity.dart';

class LikedItemsResponseEntity {
  final bool success;
  final String message;
  final List<LikedItemEntity> data;
  final dynamic errors;
  final int code;

  LikedItemsResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}