import 'package:anony_chat/model/terms_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TermsContentPage extends StatelessWidget {
  TermsData mItem;

  TermsContentPage(this.mItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          '이용약관',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54), color: Colors.white),
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(24.0),
              child: Text(mItem.content),
            ),
            ButtonTheme(
              minWidth: 160.0,
              buttonColor: Colors.amberAccent,
              child: RaisedButton(
                  child: Text(
                    '확인',
                  ),
                  onPressed: () {
                    Navigator.pop(context, mItem);
                  }),
            ),
            SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }
}
