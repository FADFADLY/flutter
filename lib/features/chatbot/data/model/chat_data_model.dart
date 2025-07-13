import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entity/chat_data_entity.dart';

part 'chat_data_model.g.dart';

@HiveType(typeId: 2)
class ChatDataModel extends ChatDataEntity {
  @HiveField(0)
  final int chatId;
  @HiveField(1)
  final String userPrompt;
  @HiveField(2)
  final String botResponse;

  const ChatDataModel({
    required this.chatId,
    required this.userPrompt,
    required this.botResponse,
  }) : super(
    chatId: chatId,
    userPrompt: userPrompt,
    botResponse: botResponse,
  );

  factory ChatDataModel.fromJson(Map<String, dynamic> json) {
    return ChatDataModel(
      chatId: json['chat_id'] as int,
      userPrompt: json['prompt'] as String,
      botResponse: json['response'] as String,
    );
  }

  factory ChatDataModel.fromEntity(ChatDataEntity entity) {
    return ChatDataModel(
      chatId: entity.chatId,
      userPrompt: entity.userPrompt,
      botResponse: entity.botResponse,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
      'prompt': userPrompt,
      'response': botResponse,
    };
  }
}