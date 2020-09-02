import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: ButtonTheme(
          minWidth: double.infinity,
          height: 50.0,
          buttonColor: Colors.amberAccent,
          child: RaisedButton(
            child: Text(text, style: TextStyle(fontSize: 24)),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  BottomButton({@required this.onPressed,@required this.text});
}
