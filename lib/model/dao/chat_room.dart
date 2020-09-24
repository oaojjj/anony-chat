import 'package:anony_chat/model/dao/message.dart';
import 'package:json_annotation/json_annotation.dart';


part 'chat_room.g.dart';

// 일단 보류
// 무조건 랜덤으로 보냄
enum ChatType {
  random,
  onlyMan,
  onlyWoman,
}

@JsonSerializable()
class ChatRoom {
  String imageIcon;
  int withWho;
  int createdTime;
  ChatType type;
  Message message;

  ChatRoom(
      {this.imageIcon,
        this.withWho,
        this.type,
        this.message}) {
    createdTime = message.time;
  }

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);

}