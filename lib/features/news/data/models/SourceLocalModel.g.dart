// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SourceLocalModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SourceLocalModelAdapter extends TypeAdapter<SourceLocalModel> {
  @override
  final int typeId = 1;

  @override
  SourceLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SourceLocalModel(
      id: fields[0] as dynamic,
      name: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, SourceLocalModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
