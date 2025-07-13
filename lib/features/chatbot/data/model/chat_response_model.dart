import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entity/chat_response_entity.dart';
import 'chat_data_model.dart';

part 'chat_response_model.g.dart';

@HiveType(typeId: 3)
class ChatResponseModel extends ChatResponseEntity {
  @HiveField(0)
  final bool success;
  @HiveField(1)
  final String responseMessage;
  @HiveField(2)
  final ChatDataModel? chatData;
  @HiveField(3)
  final dynamic errorDetails;
  @HiveField(4)
  final int statusCode;

  const ChatResponseModel({
    required this.success,
    required this.responseMessage,
    this.chatData,
    this.errorDetails,
    required this.statusCode,
  }) : super(
    isSuccess: success,
    responseMessage: responseMessage,
    chatData: chatData,
    errorDetails: errorDetails,
    statusCode: statusCode,
  );

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      success: json['success'] as bool,
      responseMessage: json['message'] as String,
      chatData: json['data'] != null
          ? ChatDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      errorDetails: json['errors'],
      statusCode: json['code'] as int,
    );
  }

  factory ChatResponseModel.fromEntity(ChatResponseEntity entity) {
    return ChatResponseModel(
      success: entity.isSuccess,
      responseMessage: entity.responseMessage,
      chatData: entity.chatData != null
          ? ChatDataModel.fromEntity(entity.chatData!)
          : null,
      errorDetails: entity.errorDetails,
      statusCode: entity.statusCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': responseMessage,
      'data': chatData?.toJson(),
      'errors': errorDetails,
      'code': statusCode,
    };
  }}