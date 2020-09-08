import 'package:flutter/material.dart';

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
  '/termsOfService': (BuildContext context) => TermsOfServicePage(),
  '/termsContent': (BuildContext context) => TermsContentPage(),
  '/register': (BuildContext context) => RegisterPage(),
  '/stdCardCertification': (BuildContext context) => SCCertification(),
  '/main': (BuildContext context) => MainPage(),
  '/profile': (BuildContext context) => ProfilePage(),
  '/serviceInfo': (BuildContext context) => ServiceInfoPage()
};
