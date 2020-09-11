import 'dart:io';

class Message {
  int senderID;
  int receiverID;
  int time;
  String content;
  bool isRead = false;
  File photo;

  Message(
      {this.senderID, this.receiverID, this.content, this.time, this.photo});

  Message.fromMap(Map<String, dynamic> map)
      : senderID = map['sender'],
        receiverID = map['receiver'],
        content = map['content'],
        isRead = map['isRead'].toString() == 'true',
        time = map['time'],
        photo = map['photo'];

  Map<String, dynamic> toJson() => {
        '$time': {
          'sender': senderID,
          'receiver': receiverID,
          'content': content,
          'isRead': isRead.toString(),
          'time': time,
          'photo': photo ?? 'null',
        }
      };
}
