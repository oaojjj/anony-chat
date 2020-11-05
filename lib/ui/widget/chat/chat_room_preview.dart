import 'package:anony_chat/utils/utill.dart';
import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:flutter/material.dart';

class ChatRoomPreview extends StatefulWidget {
  final String lastMessage;
  final String timestamp;
  final String previewIcon;
  final String chatRoomId;

  ChatRoomPreview(
      {this.lastMessage, this.timestamp, this.previewIcon, this.chatRoomId});

  @override
  _ChatRoomPreviewState createState() => _ChatRoomPreviewState();
}

class _ChatRoomPreviewState extends State<ChatRoomPreview> {
  final _chatModel = ChatModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 8, top: 8, bottom: 8),
                child: Image(
                    height: 56, image: AssetImage('${widget.previewIcon}')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    height: 72,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.lastMessage,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Positioned(
                            right: 4,
                            top: 1,
                            bottom: 1,
                            child: Container(
                              width: 20,
                              child: StreamBuilder(
                                stream: _chatModel
                                    .getUnReadMsgCountStream(widget.chatRoomId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    int unRead =
                                        snapshot.data['unReadMsgCount'];
                                    if (unRead != 0) {
                                      return CircleAvatar(
                                        backgroundColor: chatPrimaryColor,
                                        child: Text(
                                          '${unRead >= 999 ? 999 : unRead}',
                                          maxLines: 1,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else if (snapshot.hasError) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            )),
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
