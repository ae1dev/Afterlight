// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class FavoriteAppAdapter extends TypeAdapter<FavoriteApp> {
  @override
  final int typeId = 0;

  @override
  FavoriteApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteApp(
      packageName: fields[0] as String,
      placement: (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteApp obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.packageName)
      ..writeByte(1)
      ..write(obj.placement);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
