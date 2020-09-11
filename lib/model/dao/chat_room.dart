import 'package:anony_chat/model/dao/message.dart';

enum ChatType {
  random,
  onlyMan,
  onlyWoman,
}

class ChatRoom {
  // TODO 행성이미지를 파이어베이스 스토리지에 저장하고 url로 관리할지 어플에서 관리할지 고민
  // 일단 이미지 폴더에서 관리
  String planetImageName;
  String withSex;
  int chattingWith;
  ChatType type;
  Message message;

  ChatRoom({this.planetImageName, this.message, this.type, this.chattingWith});

  ChatRoom.fromMap(Map<String, dynamic> map)
      : planetImageName = map['planetImageName'],
        message = map['message'],
        chattingWith = map['chattingWith'],
        withSex = map['withSex'],
        type = map['type'];

  Map<String, dynamic> toJson() => {
        'planetImageName': planetImageName,
        'lastMessage': message.content,
        'withSex': withSex,
        'timestamp': message.time,
        'chattingWith': chattingWith,
        'type': type.toString().substring(9),
      };
}
