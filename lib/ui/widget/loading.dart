import 'package:anony_chat/utils/utill.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            height: 64.0,
            width: 64.0,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(chatPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
