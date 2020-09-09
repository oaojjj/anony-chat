import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({this.text});

  final String text;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.text, style: TextStyle(fontSize: 16.0)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text('9월9일 오후7:00', style: TextStyle(fontSize: 12.0)),
                ),
                Text('읽음', style: TextStyle(fontSize: 12.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
