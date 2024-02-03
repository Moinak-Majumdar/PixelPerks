// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_fav.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveFavAdapter extends TypeAdapter<HiveFav> {
  @override
  final int typeId = 1;

  @override
  HiveFav read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFav(
      id: fields[0] as int,
      web340: fields[1] as String,
      isSafe: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFav obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.web340)
      ..writeByte(2)
      ..write(obj.isSafe);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFavAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
