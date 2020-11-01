import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int senderID;
  int receiverID;
  int time;
  String type;
  String content;
  bool isRead;

  Message(
      {this.senderID,
      this.receiverID,
      this.content,
      this.type = 'text',
      this.time,
      this.isRead = false});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
