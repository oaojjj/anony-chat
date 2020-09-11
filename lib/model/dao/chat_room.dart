import 'package:anony_chat/model/dao/message.dart';

enum ChatType {
  random,
  onlyMan,
  onlyWoman,
}

class ChatRoom {
  // TODO 행성이미지를 파이어베이스 스토리지에 저장하고 url로 관리할지 어플에서 관리할지 고민
  // 일단 이미지 폴더에서 관리
  String planetName;
  Message message;
  ChatType type;

  ChatRoom({this.planetName, this.message, this.type});

  ChatRoom.fromMap(Map<String, dynamic> map)
      : planetName = map['planetName'],
        message = map['message'],
        type = map['type'];

  Map<String, dynamic> toJson() => {
        'planetName': planetName,
        'lastMessage': message.content,
        'timestamp': message.time,
        'type': type.toString().substring(9),
      };
}
