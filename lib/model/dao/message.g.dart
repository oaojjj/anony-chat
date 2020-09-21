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
    time: json['time'] as int,
  )..isRead = json['isRead'] as bool;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '${instance.time}': {
        'senderID': instance.senderID,
        'receiverID': instance.receiverID,
        'time': instance.time,
        'content': instance.content,
        'isRead': instance.isRead,
      }
    };
