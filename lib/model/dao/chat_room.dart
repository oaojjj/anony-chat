import 'package:anony_chat/model/dao/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  String imageIcon;
  String chatRoomID;
  bool activation;
  int withWho;
  int createdTime;
  int unReadMsgCount;
  Message message;

  ChatRoom({
    this.imageIcon,
    this.withWho,
    this.unReadMsgCount = 0,
    this.message,
    this.createdTime,
    this.chatRoomID,
    this.activation = false,
  }) {
    createdTime = message.time;
  }

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}
