import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: 160.0,
                width: 160.0,
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/earth.png'))),
            SizedBox(height: size.height * 0.4),
            BottomButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/terms_of_service'),
                text: '시작하기'),
            SizedBox(height: size.height * 0.05)
          ],
        ),
      ),
    );
  }
}
