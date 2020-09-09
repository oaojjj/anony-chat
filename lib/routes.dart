import 'package:flutter/material.dart';

import 'ui/view/chat/chat_list_page.dart';
import 'ui/view/chat/chat_room_page.dart';
import 'ui/view/chat/chat_send_page.dart';
import 'ui/view/home/main_home_page.dart';
import 'ui/view/home/profile_page.dart';
import 'ui/view/home/service_info_page.dart';
import 'ui/view/intro/intro_page.dart';
import 'ui/view/intro/register_page.dart';
import 'ui/view/intro/student_card_certification_page.dart';
import 'ui/view/intro/terms_content_page.dart';
import 'ui/view/intro/terms_of_service_page.dart';

final routes = {
  //'/': (BuildContext context) => IntroPage(),
  '/intro': (BuildContext context) => IntroPage(),
  '/terms_of_service': (BuildContext context) => TermsOfServicePage(),
  '/terms_content': (BuildContext context) => TermsContentPage(),
  '/register': (BuildContext context) => RegisterPage(),
  '/std_card_certification': (BuildContext context) => SCCertification(),
  '/main': (BuildContext context) => MainPage(),
  '/profile': (BuildContext context) => ProfilePage(),
  '/service_info': (BuildContext context) => ServiceInfoPage(),
  '/chat': (BuildContext context) => ChatRoomPage(),
  '/chat_list': (BuildContext context) => ChatListPage(),
  '/chat_send': (BuildContext context) => ChatSendPage()
};
