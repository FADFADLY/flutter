// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatListResponseModelAdapter extends TypeAdapter<ChatListResponseModel> {
  @override
  final int typeId = 1;

  @override
  ChatListResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatListResponseModel(
      success: fields[0] as bool,
      message: fields[1] as String,
      chatModels: (fields[2] as List).cast<ChatItemModel>(),
      errors: fields[3] as dynamic,
      code: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatListResponseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.chatModels)
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
      other is ChatListResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
