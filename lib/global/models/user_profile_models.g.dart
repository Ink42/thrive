// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileModelsAdapter extends TypeAdapter<UserProfileModels> {
  @override
  final int typeId = 0;

  @override
  UserProfileModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileModels(
      userEmail: fields[2] as String,
      userID: fields[0] as String,
      userName: fields[1] as String,
      userProfilePicture: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileModels obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.userEmail)
      ..writeByte(3)
      ..write(obj.userProfilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
