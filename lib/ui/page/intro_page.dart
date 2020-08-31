import 'package:anony_chat/style/style.dart';
import 'package:flutter/material.dart';

import 'terms_of_use_page.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Style.instance.of(context).initScreenSize();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                height: 160.0,
                width: 160.0,
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/dog.png'))),
            SizedBox(height: Style.instance.size.height * 0.4),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 50.0,
                  buttonColor: Colors.amberAccent,
                  child: RaisedButton(
                      child: Text('시작하기', style: TextStyle(fontSize: 28)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsOfUsePage()));
                      }),
                ),
              ),
            ),
            SizedBox(height: Style.instance.size.height * 0.05)
          ],
        ),
      ),
    );
  }
}
