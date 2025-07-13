// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatItemModelAdapter extends TypeAdapter<ChatItemModel> {
  @override
  final int typeId = 0;

  @override
  ChatItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatItemModel(
      id: fields[0] as int,
      title: fields[1] as String,
      dateTime: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatItemModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
