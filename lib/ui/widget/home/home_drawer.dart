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
              leading: Image.asset('assets/icons/profile.png', height: 27),
              title: Text('내 프로필', style: TextStyle(fontSize: 18.0)),
              dense: true,
              onTap: () => Navigator.pushNamed(context, '/profile_page'),
            ),
            ListTile(
              leading: Image.asset('assets/icons/report.png', height: 25),
              title: Text('신고 내역', style: TextStyle(fontSize: 18.0)),
              onTap: () => Navigator.pushNamed(context, '/report_page'),
            ),
            ListTile(
              leading: Icon(Icons.store, size: 30.0),
              title: Text('아이템 상점', style: TextStyle(fontSize: 18.0)),
              onTap: () => Navigator.pushNamed(context, '/item_store_page'),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, size: 30),
              title: Text('서비스 정보', style: TextStyle(fontSize: 18.0)),
              onTap: () => Navigator.pushNamed(context, '/service_info_page'),
            ),
            ListTile(
              title: Text('테스트', style: TextStyle(fontSize: 20.0)),
              onTap: () async {},
            )
          ],
        ),
      ),
    );
  }
}
