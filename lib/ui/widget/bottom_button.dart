import 'package:flutter/material.dart';
import 'package:anony_chat/utils/utill.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 50.0,
        buttonColor: color,
        child: RaisedButton(
          child: Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          onPressed: onPressed,
        ),
      ),
    );
  }
  BottomButton({this.onPressed, this.text, this.color = chatPrimaryColor});
}
