import 'package:flutter/material.dart';

class ChatRoomPreview extends StatefulWidget {
  final String title;
  final String sex;
  final String date;
  final String imagePath;

  ChatRoomPreview({this.title, this.sex, this.date, this.imagePath});

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
                    height: 64.0, image: AssetImage('${widget.imagePath}')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text(widget.sex,
                          style: TextStyle(color: Colors.amberAccent)),
                      Row(
                        children: [
                          Spacer(),
                          Text(widget.date,
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
