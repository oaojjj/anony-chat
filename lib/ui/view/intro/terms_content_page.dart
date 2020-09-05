import 'package:anony_chat/model/dao/terms_data.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsContentPage extends StatefulWidget {
  final TermsData mItem;
  const TermsContentPage(this.mItem);

  @override
  _TermsContentPageState createState() => _TermsContentPageState();
}

class _TermsContentPageState extends State<TermsContentPage> {
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
              child: Text(widget.mItem.content),
            ),
            BottomButton(
                onPressed: () {
                  Navigator.pop(context, widget.mItem);
                },
                text: '동의'),
            SizedBox(height: size.height * 0.05)
          ],
        ),
      ),
    );
  }
}
