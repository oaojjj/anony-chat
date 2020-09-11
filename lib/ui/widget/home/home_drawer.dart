import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.0,
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.account_circle, size: 24.0),
              title: Text('내 프로필', style: TextStyle(fontSize: 20.0)),
              dense: true,
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: Icon(Icons.report, size: 24.0),
              title: Text('신고 내역', style: TextStyle(fontSize: 20.0)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.store, size: 24.0),
              title: Text('아이템 상점', style: TextStyle(fontSize: 20.0)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 24.0),
              title: Text('서비스 정보', style: TextStyle(fontSize: 20.0)),
              onTap: () => Navigator.pushNamed(context, '/service_info'),
            ),
            ListTile(
              title: Text('테스트', style: TextStyle(fontSize: 20.0)),
              onTap: () {
              },
            )
          ],
        ),
      ),
    );
  }
}
