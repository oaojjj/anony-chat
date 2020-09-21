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
  // TODO 행성이미지를 파이어베이스 스토리지에 저장하고 url로 관리할지 어플에서 관리할지 고민
  // 일단 이미지 폴더에서 관리
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
