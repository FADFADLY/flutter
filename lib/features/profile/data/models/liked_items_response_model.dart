import 'package:graduationproject/features/profile/data/models/liked_item_model.dart';
import '../../domain/entity/liked_items_response_entity.dart';

class LikedItemsResponseModel extends LikedItemsResponseEntity {
  LikedItemsResponseModel({
    required bool success,
    required String message,
    required List<LikedItemModel> data,
    required dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory LikedItemsResponseModel.fromJson(Map<String, dynamic> json) {
    return LikedItemsResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List).map((item) => LikedItemModel.fromJson(item as Map<String, dynamic>)).toList(),
      errors: json['errors'],
      code: json['code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => (item as LikedItemModel).toJson()).toList(),
      'errors': errors,
      'code': code,
    };
  }
}