import 'package:flutter/material.dart';

class ChatRoomPreview extends StatefulWidget {
  final String lastMessage;
  final String sex;
  final String timestamp;
  final String planetName;

  ChatRoomPreview({this.lastMessage, this.sex, this.timestamp, this.planetName});

  @override
  _ChatRoomPreviewState createState() => _ChatRoomPreviewState();
}

class _ChatRoomPreviewState extends State<ChatRoomPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 24, top: 16, bottom: 8),
                child: Image(
                    height: 64.0, image: AssetImage('${widget.planetName}')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.lastMessage,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text(widget.sex,
                          style: TextStyle(color: Colors.amberAccent)),
                      Row(
                        children: [
                          Spacer(),
                          Text(widget.timestamp,
                              style: TextStyle(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
              height: 1, indent: 104, thickness: 0.4, color: Colors.amberAccent)
        ],
      ),
    );
  }
}
