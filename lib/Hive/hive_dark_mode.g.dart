// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_dark_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDarkModeAdapter extends TypeAdapter<HiveDarkMode> {
  @override
  final int typeId = 2;

  @override
  HiveDarkMode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDarkMode(
      isDarkMode: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDarkMode obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDarkModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
