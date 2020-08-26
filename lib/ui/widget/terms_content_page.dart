import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsContentPage extends StatelessWidget {
  String mContent;

  TermsContentPage(this.mContent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('이용약관'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(16.0),
          child: Text(mContent),
        ),
      ),
    );
  }
}
