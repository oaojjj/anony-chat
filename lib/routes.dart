import 'package:flutter/material.dart';

import 'ui/view/chat/chat_list_page.dart';
import 'ui/view/chat/chat_room_page.dart';
import 'ui/view/chat/chat_send_page.dart';
import 'ui/view/home/main_home_page.dart';
import 'ui/view/home/profile_page.dart';
import 'ui/view/home/report_guide_page.dart';
import 'ui/view/home/report_page.dart';
import 'ui/view/home/service_info_page.dart';
import 'ui/view/intro/intro_page.dart';
import 'ui/view/intro/auth_and_register.dart';
import 'ui/view/intro/terms_content_page.dart';

final routes = {
  //'/': (BuildContext context) => IntroPage(),
  '/intro_page': (BuildContext context) => IntroPage(),
  '/auth_and_register_page': (BuildContext context) =>
      AuthAndRegisterPage(),
  '/terms_content_page': (BuildContext context) => TermsContentPage(),
  '/main': (BuildContext context) => MainPage(),
  '/profile_page': (BuildContext context) => ProfilePage(),
  '/service_info_page': (BuildContext context) => ServiceInfoPage(),
  '/chat_page': (BuildContext context) => ChatRoomPage(),
  '/chat_list_page': (BuildContext context) => ChatListPage(),
  '/chat_send_page': (BuildContext context) => ChatSendPage(),
  '/report_page': (BuildContext context) => ReportPage(),
  '/report_guide_page': (BuildContext context) => ReportGuidePage()
};
