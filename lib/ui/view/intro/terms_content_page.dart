import 'package:anony_chat/model/dao/terms_data.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:flutter/material.dart';

class TermsContentPage extends StatefulWidget {
  @override
  _TermsContentPageState createState() => _TermsContentPageState();
}

class _TermsContentPageState extends State<TermsContentPage> {
  @override
  Widget build(BuildContext context) {
    TermsData item = ModalRoute.of(context).settings.arguments;

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('이용약관', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.all(16.0),
                child: Text(item.content),
              ),
              BottomButton(
                  onPressed: () => Navigator.pop(context, item), text: '동의'),
              SizedBox(height: size.height * 0.05)
            ],
          ),
        ),
      ),
    );
  }
}
