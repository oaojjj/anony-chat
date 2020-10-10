import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({this.message});

  final Message message;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<ChatMessage> {
  bool isSendByMe;

  @override
  void initState() {
    super.initState();
    isSendByMe =
        widget.message.senderID == HiveController.instance.getMemberID();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            isSendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Container(
                decoration: BoxDecoration(
                  color: isSendByMe ? Colors.black : chatPrimaryColor,
                  borderRadius: isSendByMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                          bottomLeft: Radius.circular(32.0),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0),
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(widget.message.content,
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                )),
          ),
          Padding(
            padding: isSendByMe
                ? const EdgeInsets.only(right: 16.0, bottom: 8.0)
                : const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment:
                  isSendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text(formatTime(widget.message.time),
                      style: TextStyle(fontSize: 12.0, color: Colors.black)),
                ),
                !isSendByMe
                    ? Container()
                    : Text(widget.message.isRead ? '읽음' : '안읽음',
                        style: TextStyle(fontSize: 12.0)),
              ],
            ),
          )
        ],
      ),
    );
  }

  String formatTime(int time) {
    return DateFormat('hh:mm aa')
        .format(DateTime.fromMillisecondsSinceEpoch(time))
        .toString();
  }
}
