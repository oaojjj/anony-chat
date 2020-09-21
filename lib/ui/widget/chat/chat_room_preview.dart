import 'package:flutter/material.dart';

class ChatRoomPreview extends StatefulWidget {
  final String lastMessage;
  final String timestamp;
  final String previewIcon;

  ChatRoomPreview({this.lastMessage, this.timestamp, this.previewIcon});

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
                    height: 64.0, image: AssetImage('${widget.previewIcon}')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.lastMessage,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Row(
                        children: [
                          Spacer(),
                          Text(widget.timestamp,
                              style: TextStyle(color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
              height: 1, indent: 104, thickness: 0.4, color: Colors.black)
        ],
      ),
    );
  }
}
