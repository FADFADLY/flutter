import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entity/chat_message_entity.dart';

part 'chat_message_model.g.dart';

@HiveType(typeId: 4)
class ChatMessageModel extends ChatMessageEntity {
  @HiveField(0)
  final String prompt;
  @HiveField(1)
  final String response;
  @HiveField(2)
  final String dateTime;

  const ChatMessageModel({
    required this.prompt,
    required this.response,
    required this.dateTime,
  }) : super(prompt: prompt, response: response, dateTime: dateTime);

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      prompt: json['prompt'] as String,
      response: json['response'] as String,
      dateTime: json['date_time'] as String,
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      prompt: entity.prompt,
      response: entity.response,
      dateTime: entity.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
      'response': response,
      'date_time': dateTime,
    };
  }
}