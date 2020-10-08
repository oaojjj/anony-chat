// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    senderID: json['senderID'] as int,
    receiverID: json['receiverID'] as int,
    content: json['content'] as String,
    type: json['type'] as String,
    time: json['time'] as int,
  )..isRead = json['isRead'] as bool;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
    'senderID': instance.senderID,
    'receiverID': instance.receiverID,
    'time': instance.time,
    'content': instance.content,
    'type': instance.type,
    'isRead': instance.isRead,
};