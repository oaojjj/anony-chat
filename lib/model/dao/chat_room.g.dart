// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return ChatRoom(
    imageIcon: json['imageIcon'] as String,
    withWho: json['withWho'] as int,
    message: json['message'] == null
        ? null
        : Message.fromJson(json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
  'imageIcon': instance.imageIcon,
  'withWho': instance.withWho,
  'lastMessageTime': instance.message.time,
  'lastMessage': instance.message.content,
};