import 'package:anony_chat/model/dao/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  String imageIcon;
  int withWho;
  int createdTime;
  Message message;

  ChatRoom(
      {this.imageIcon,
        this.withWho,
        this.message}) {
    createdTime = message.time;
  }

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);

}