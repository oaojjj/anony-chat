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
                    left: 16, right: 16, top: 16, bottom: 16),
                child: Image(
                    height: 48.0, image: AssetImage('${widget.previewIcon}')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    height: 80,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.lastMessage,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14.0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 4,
                          child: Text(widget.timestamp,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              thickness: 1,
              color: Colors.grey[300])
        ],
      ),
    );
  }
}
