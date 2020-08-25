import 'package:flutter/material.dart';

import 'TermsOfUsePage.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/dog.png'),
              radius: 64.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
                child: Text(
                  '시작하기',
                  style: TextStyle(fontSize: 32),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsOfUsePage()));
                })
          ],
        ),
      ),
    );
  }
}
