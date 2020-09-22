import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  String content =
      '서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용서비스약관내용';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '서비스약관',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            child: Divider(
              endIndent: 20,
              indent: 20,
              height: 1,
              thickness: 5,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(child: Text(content)),
        ),
      ),
    );
  }
}
