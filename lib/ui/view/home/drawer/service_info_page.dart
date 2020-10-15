import 'package:anony_chat/controller/hive_controller.dart';
import 'package:anony_chat/ui/view/join/intro_page.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceInfoPage extends StatefulWidget {
  @override
  _ServiceInfoPageState createState() => _ServiceInfoPageState();
}

class _ServiceInfoPageState extends State<ServiceInfoPage> {
  int newVersion = 100;
  int myAppVersion = 100;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '서비스정보',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Container(
          child: ListView(
            children: [
              ListTile(
                  title: Text('버전', style: TextStyle(fontSize: 20.0)),
                  trailing: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: newVersion > myAppVersion ? '업데이트필요 ' : '최신 ',
                      style: TextStyle(color: chatPrimaryColor, fontSize: 12),
                    ),
                    TextSpan(
                        text: getVersionString(),
                        style:
                        TextStyle(fontSize: 20.0, color: chatPrimaryColor)),
                  ]))),
              Divider(
                color: Colors.black,
                thickness: 0.5,
                height: 0,
              ),
              ListTile(
                title: Text('서비스약관', style: TextStyle(fontSize: 20.0)),
                onTap: () =>
                    Navigator.pushNamed(context, '/terms_of_service_page'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.5,
                height: 0,
              ),
              ListTile(
                title: Text('개인정보취급방침', style: TextStyle(fontSize: 20.0)),
                onTap: () =>
                    Navigator.pushNamed(context, '/privacy_statement_page'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.5,
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getVersionString() {
    return '${myAppVersion.toString().replaceAllMapped(
        RegExp(r'.{1}'), (match) => '${match.group(0)}.').substring(0, 5)}';
  }
}
