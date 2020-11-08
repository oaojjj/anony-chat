import 'package:anony_chat/controller/notification_controller.dart';
import 'package:anony_chat/provider/message_provider.dart';
import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/provider/auth_provider.dart';
import 'package:anony_chat/routes.dart';
import 'package:anony_chat/ui/view/join/intro_page.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationController.instance.firebaseMessaging
      .requestNotificationPermissions();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  headers['Content-Type'] = 'application/json; charset=utf-8';
  await Hive.initFlutter();
  await Hive.openBox('member');
  await Hive.openBox('auth');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RegisterProvider()),
        ChangeNotifierProvider.value(value: AuthProvider()),
        //ChangeNotifierProvider.value(value: MessageProvider()),
      ],
      child: AnonymousChat(),
    ),
  );
}

class AnonymousChat extends StatefulWidget {
  @override
  _AnonymousChatState createState() => _AnonymousChatState();
}

class _AnonymousChatState extends State<AnonymousChat> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await NotificationController.instance.takeFCMTokenWhenAppLaunch();
      await NotificationController.instance.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = "3f713a24ffd507e39016b356d25530e4";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anonymous Chat',
      theme: ThemeData(
          fontFamily: 'Roboto',
          buttonColor: chatPrimaryColor,
          primaryColor: chatPrimaryColor,
          accentColor: chatAccentColor),
      home: IntroPage(),
      routes: routes,
    );
  }
}
