import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({this.text});

  final String text;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<ChatMessage> {
  bool isSendByMe = true;

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
                  color: isSendByMe ? Colors.amberAccent : Colors.white12,
                  borderRadius: isSendByMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(widget.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: isSendByMe ? Colors.black : Colors.white)),
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
                  child: Text('9월9일 오후7:00',
                      style: TextStyle(fontSize: 12.0, color: Colors.white)),
                ),
                isSendByMe
                    ? Container()
                    : Text('읽음', style: TextStyle(fontSize: 12.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
