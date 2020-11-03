import 'package:anony_chat/ui/view/home/ad_watching_page.dart';
import 'package:anony_chat/ui/view/join/student_card_authorization_page.dart';
import 'package:flutter/material.dart';

import 'ui/view/chat/chat_list_page.dart';
import 'ui/view/chat/chat_room_page.dart';
import 'ui/view/chat/chat_send_page.dart';
import 'ui/view/chat/chat_report_page.dart';
import 'ui/view/home/drawer/item_store_page.dart';
import 'ui/view/home/drawer/service_info_page.dart';
import 'ui/view/home/main_home_page.dart';
import 'ui/view/home/drawer/privacy_statement_page.dart';
import 'ui/view/home/drawer/profile_page.dart';
import 'ui/view/home/drawer/report_guide_page.dart';
import 'ui/view/home/drawer/report_page.dart';
import 'ui/view/home/drawer/terms_of_service_page.dart';
import 'ui/view/join/intro_page.dart';

final routes = {
  '/intro_page': (BuildContext context) => IntroPage(),
  '/student_card_authorization_page': (BuildContext context) => SCAuthorizationPage(),
  '/main_page': (BuildContext context) => MainPage(),
  '/profile_page': (BuildContext context) => ProfilePage(),
  '/service_info_page': (BuildContext context) => ServiceInfoPage(),
  '/terms_of_service_page': (BuildContext context) => TermsOfServicePage(),
  '/privacy_statement_page': (BuildContext context) => PrivacyStatementPage(),
  '/chat_page': (BuildContext context) => ChatRoomPage(),
  '/chat_list_page': (BuildContext context) => ChatListPage(),
  '/chat_send_page': (BuildContext context) => ChatSendPage(),
  '/chat_report_page': (BuildContext context) => ChatReportPage(),
  '/report_page': (BuildContext context) => ReportPage(),
  '/report_guide_page': (BuildContext context) => ReportGuidePage(),
  '/item_store_page': (BuildContext context) => ItemStorePage(),
  '/ad_watching_page': (BuildContext context) => AdWatchingPage(),
};
