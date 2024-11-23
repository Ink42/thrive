// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityModelsAdapter extends TypeAdapter<ActivityModels> {
  @override
  final int typeId = 1;

  @override
  ActivityModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityModels(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
      fields[3] as int,
      fields[4] as DateTime,
      (fields[5] as List).cast<dynamic>(),
      fields[6] as String,
      fields[8] as String,
      fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityModels obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.activityId)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.route)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.complete)
      ..writeByte(8)
      ..write(obj.summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
