// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatDataModelAdapter extends TypeAdapter<ChatDataModel> {
  @override
  final int typeId = 2;

  @override
  ChatDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatDataModel(
      chatId: fields[0] as int,
      userPrompt: fields[1] as String,
      botResponse: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.chatId)
      ..writeByte(1)
      ..write(obj.userPrompt)
      ..writeByte(2)
      ..write(obj.botResponse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
