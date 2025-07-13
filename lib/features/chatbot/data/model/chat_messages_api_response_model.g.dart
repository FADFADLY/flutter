// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_api_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessagesApiResponseModelAdapter
    extends TypeAdapter<ChatMessagesApiResponseModel> {
  @override
  final int typeId = 5;

  @override
  ChatMessagesApiResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessagesApiResponseModel(
      success: fields[0] as bool,
      message: fields[1] as String,
      data: (fields[2] as List).cast<ChatMessageModel>(),
      errors: fields[3] as dynamic,
      code: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessagesApiResponseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.errors)
      ..writeByte(4)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessagesApiResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
