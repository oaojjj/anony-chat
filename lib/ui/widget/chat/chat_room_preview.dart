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
                padding: const EdgeInsets.only(left: 16, right: 24, top: 16),
                child: Image(
                    height: 64.0, image: AssetImage('${widget.imagePath}')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    Text(widget.sex,
                        style: TextStyle(color: Colors.amberAccent))
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 56, right: 16),
                child: Text(widget.date, style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          Divider(indent: 104.0, thickness: 0.4, color: Colors.amberAccent)
        ],
      ),
    );
  }
}
