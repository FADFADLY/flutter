// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatResponseModelAdapter extends TypeAdapter<ChatResponseModel> {
  @override
  final int typeId = 3;

  @override
  ChatResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatResponseModel(
      success: fields[0] as bool,
      responseMessage: fields[1] as String,
      chatData: fields[2] as ChatDataModel?,
      errorDetails: fields[3] as dynamic,
      statusCode: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatResponseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isSuccess)
      ..writeByte(1)
      ..write(obj.responseMessage)
      ..writeByte(2)
      ..write(obj.chatData)
      ..writeByte(3)
      ..write(obj.errorDetails)
      ..writeByte(4)
      ..write(obj.statusCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
