import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entity/chat_item_entity.dart';

part 'chat_item_model.g.dart';

@HiveType(typeId: 0)
class ChatItemModel extends ChatItemEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String dateTime;

  const ChatItemModel({
    required this.id,
    required this.title,
    required this.dateTime,
  }) : super(id: id, title: title, dateTime: dateTime);

  factory ChatItemModel.fromJson(Map<String, dynamic> json) {
    return ChatItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      dateTime: json['date_time'] as String,
    );
  }

  factory ChatItemModel.fromEntity(ChatItemEntity entity) {
    return ChatItemModel(
      id: entity.id,
      title: entity.title,
      dateTime: entity.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date_time': dateTime,
    };
  }
}