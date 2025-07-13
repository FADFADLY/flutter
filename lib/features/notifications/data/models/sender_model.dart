import '../../domain/entity/sender_entity.dart';

class SenderModel extends SenderEntity {
  SenderModel({
    required String username,
    String? image,
  }) : super(
          username: username,
          image: image,
        );

  factory SenderModel.fromJson(Map<String, dynamic> json) {
    return SenderModel(
      username: json['username'] as String,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'image': image,
    };
  }
}