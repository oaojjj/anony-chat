import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceInfoPage extends StatefulWidget {
  @override
  _ServiceInfoPageState createState() => _ServiceInfoPageState();
}

class _ServiceInfoPageState extends State<ServiceInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('서비스정보'),
          centerTitle: true,
        ),
        body: Container(
          child: ListView(
            children: [
              ListTile(
                title: Text('버전 정보', style: TextStyle(fontSize: 20.0)),
                trailing: Text('1.0', style: TextStyle(fontSize: 20.0)),
                onTap: () {},
              ),
              Divider(color: Colors.black, thickness: 1.0),
              ListTile(
                title: Text('서비스 이용약관', style: TextStyle(fontSize: 20.0)),
                onTap: () {},
              ),
              Divider(color: Colors.black, thickness: 1.0),
              ListTile(
                title: Text('회원 탈퇴', style: TextStyle(fontSize: 20.0)),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/intro_page', (route) => false);
                },
              ),
              Divider(color: Colors.black, thickness: 1.0),
            ],
          ),
        ),
      ),
    );
  }
}
