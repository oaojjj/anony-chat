import 'dart:io';

class Message {
  int senderID;
  String content;
  int time;
  File photo;

  Message({this.senderID, this.content, this.time, this.photo});

  Message.fromMap(Map<String, dynamic> map)
      : senderID = map['sender'],
        content = map['content'],
        time = map['time'],
        photo = map['photo'];


  Map<String, dynamic> toJson() =>
      {
        '$time': {
          'sender': senderID,
          'content': content,
          'time': time,
          'photo': photo ?? 'null',
        }
      };
}
