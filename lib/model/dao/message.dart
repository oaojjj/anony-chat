import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int senderID;
  int receiverID;
  int time;
  String content;
  bool isRead = false;

  Message(
      {this.senderID, this.receiverID, this.content, this.time});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);


}
