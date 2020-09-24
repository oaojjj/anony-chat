import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: 120.0,
                  width: 120.0,
                  child: CircleAvatar(
                    child: Text('익명 메신저\n어플',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.black12,
                  )),
              SizedBox(height: deviceSize.height * 0.25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BottomButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/auth_and_register_page'),
                    text: '시작하기'),
              ),
              SizedBox(height: deviceSize.height * 0.25)
            ],
          ),
        ),
      ),
    );
  }
}
