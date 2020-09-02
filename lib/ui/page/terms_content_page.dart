import 'package:anony_chat/model/terms_data.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TermsContentPage extends StatelessWidget {
  TermsData mItem;

  TermsContentPage(this.mItem);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('이용약관', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black26)),
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              child: Text(mItem.content),
            ),
            BottomButton(
                onPressed: () {
                  Navigator.pop(context, mItem);
                },
                text: '동의'),
            SizedBox(height: size.height * 0.05)
          ],
        ),
      ),
    );
  }
}
