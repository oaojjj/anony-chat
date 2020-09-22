import 'package:flutter/material.dart';

class ReportGuidePage extends StatelessWidget {
  final String content =
      '규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구규정아내문구';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Container(
          width: 135,
          child: Row(
            children: [
              Icon(Icons.help),
              Text(
                '신고규정안내',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
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
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Text(content),
        ),
      ),
    ));
  }
}
