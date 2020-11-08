import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/model/dao/message.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../full_photo.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({this.message});

  final Message message;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<ChatMessage> {
  bool isSendByMe;

  static const double CHAT_FONT_SIZE = 14.0;
  static const double CHAT_CONTAINER_HEIGHT_MARGIN = 4.0;
  static const double CHAT_CONTAINER_RADIUS = 24.0;

  @override
  Widget build(BuildContext context) {
    isSendByMe =
        widget.message.senderID == HiveController.instance.getMemberID();
    return Container(
      child: Column(
        crossAxisAlignment:
            isSendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          /*widget.needDivider
              ? Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                    thickness: 0.3,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(widget.timeLine),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                  )),
                ])
              : Container(),*/
          Padding(
            padding: const EdgeInsets.only(
                left: 16, right: 16, top: CHAT_CONTAINER_HEIGHT_MARGIN),
            child: widget.message.type == 'text'
                ? Container(
                    decoration: BoxDecoration(
                      color: isSendByMe ? Colors.black : chatPrimaryColor,
                      borderRadius: isSendByMe
                          ? BorderRadius.only(
                              topLeft: Radius.circular(CHAT_CONTAINER_RADIUS),
                              topRight: Radius.circular(CHAT_CONTAINER_RADIUS),
                              bottomLeft:
                                  Radius.circular(CHAT_CONTAINER_RADIUS),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(CHAT_CONTAINER_RADIUS),
                              topRight: Radius.circular(CHAT_CONTAINER_RADIUS),
                              bottomRight:
                                  Radius.circular(CHAT_CONTAINER_RADIUS),
                            ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.message.content,
                          style: TextStyle(
                              fontSize: CHAT_FONT_SIZE, color: Colors.white)),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: isSendByMe
                          ? BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                            ),
                    ),
                    child: _imageMessage(widget.message.content),
                  ),
          ),
          Padding(
            padding: isSendByMe
                ? const EdgeInsets.only(
                    right: 16.0, bottom: CHAT_CONTAINER_HEIGHT_MARGIN)
                : const EdgeInsets.only(
                    left: 16.0, bottom: CHAT_CONTAINER_HEIGHT_MARGIN),
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

  Widget _imageMessage(imageUrlFromFB) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullPhoto(url: imageUrlFromFB),
            ),
          );
        },
        child: CachedNetworkImage(
          imageUrl: imageUrlFromFB,
          placeholder: (context, url) => Container(
            transform: Matrix4.translationValues(0, 0, 0),
            child: Container(
              width: 60,
              height: 80,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          width: 60,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
