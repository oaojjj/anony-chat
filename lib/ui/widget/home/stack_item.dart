import 'dart:math';

import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/ui/view/chat/chat_room_page.dart';
import 'package:anony_chat/viewmodel/chat_firebase_model.dart';
import 'package:flutter/material.dart';

class StackItem extends StatefulWidget {
  StackItem({this.minDY, this.maxDY, this.deviceX, this.chatRoom});

  final chatRoom;
  final double minDY;
  final double maxDY;
  final double deviceX;

  @override
  _StackItemState createState() => _StackItemState();
}

class _StackItemState extends State<StackItem> {
  final _chatModel = ChatModel();

  int xPosition = 0;
  int yPosition = 0;

  @override
  void initState() {
    int min = widget.minDY.toInt();
    int max = widget.maxDY.toInt();
    yPosition = min + Random().nextInt(max - min);
    xPosition = Random().nextInt(widget.deviceX.toInt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition.toDouble(),
      left: xPosition.toDouble(),
      child: GestureDetector(
        onTap: () async {
          _chatModel.setChatActivation(
              HiveController.instance.getMemberID(), widget.chatRoom.id, true);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomPage(
                  senderID: HiveController.instance.getMemberID(),
                  receiverID: widget.chatRoom['withWho'],
                  chatRoomID: widget.chatRoom.id),
            ),
          );
        },
        child: Container(
          child: Image(
              image: AssetImage(
                  'assets/icons/messageIcons/${widget.chatRoom['imageIcon']}')),
          width: 64,
          height: 64,
        ),
      ),
    );
  }
}
