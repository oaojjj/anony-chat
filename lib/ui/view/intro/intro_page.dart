import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
              height: 160.0,
              width: 160.0,
              child: CircleAvatar(backgroundImage: AssetImage('assets/images/dog.png'))),
          SizedBox(height: size.height * 0.4),
          BottomButton(
              onPressed: () => Navigator.pushNamed(context, '/termsOfService'),
              text: '시작하기'),
          SizedBox(height: size.height * 0.05)
        ],
      ),
    );
  }
}
