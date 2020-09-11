import 'dart:io';

class Message {
  String sender;
  String content;
  DateTime time;
  File photo;

  Message({this.sender, this.content, this.time, this.photo});

  Message.fromMap(Map<String, dynamic> map)
      : sender = map['sender'],
        content = map['content'],
        time = map['time'],
        photo = map['photo'];

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'content': content,
        'time': time,
        'photo': photo,
      };
}
