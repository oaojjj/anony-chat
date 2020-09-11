import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/model/member_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: FutureBuilder(
            future: MemberModel.getPossibleMessageOfSend(),
            builder: (_, snap) {
              if (!snap.hasData) return CircularProgressIndicator();
              return Text('남은 메세지: ${snap.data}개',
                  style: TextStyle(color: Colors.white));
            }),
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ButtonTheme(
                buttonColor: Colors.white,
                minWidth: 72.0,
                child: RaisedButton(
                    child: Text('광고+1',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {}),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Container(
            width: 64.0,
            height: 64.0,
            child: InkWell(
              child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/moon.png')),
              onTap: () => Navigator.pushNamed(context, '/chat'),
            ),
          ),
        ),
      ),
    );
  }
}
