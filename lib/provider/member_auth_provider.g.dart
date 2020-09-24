// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_auth_provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthStatusAdapter extends TypeAdapter<AuthStatus> {
  @override
  final int typeId = 1;

  @override
  AuthStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AuthStatus.registered;
      case 1:
        return AuthStatus.nonRegistered;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, AuthStatus obj) {
    switch (obj) {
      case AuthStatus.registered:
        writer.writeByte(0);
        break;
      case AuthStatus.nonRegistered:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
