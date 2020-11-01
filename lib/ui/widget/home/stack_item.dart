import 'dart:math';

import 'package:flutter/material.dart';

class StackItem extends StatefulWidget {
  StackItem(this.minDX, this.maxDX, this.deviceY);

  double minDX;
  double maxDX;
  double deviceY;

  @override
  _StackItemState createState() => _StackItemState();
}

class _StackItemState extends State<StackItem> {
  int xPosition = 0;
  int yPosition = 0;

  @override
  void initState() {
    super.initState();
    int min = widget.minDX.toInt();
    int max = widget.maxDX.toInt();
    xPosition = min + Random().nextInt(max - min);
    yPosition = Random().nextInt(widget.deviceY.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition.toDouble(),
      left: xPosition.toDouble(),
      child: Container(
        width: 50,
        height: 50,
      ),
    );
  }
}
