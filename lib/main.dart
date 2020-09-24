import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/provider/member_auth_provider.dart';
import 'package:anony_chat/routes.dart';
import 'package:anony_chat/ui/view/route_page.dart';
import 'package:anony_chat/utils/utill.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
   Hive.registerAdapter(AuthStatusAdapter());
  await Hive.openBox('member');
  await Hive.openBox('auth');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RegisterProvider()),
        ChangeNotifierProvider.value(value: MemberAuthProvider()),
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      theme: ThemeData(
          fontFamily: 'Roboto',
          buttonColor: chatPrimaryColor,
          primaryColor: chatPrimaryColor,
          accentColor: chatAccentColor),
      home: RoutePage(),
      routes: routes,
    );
  }
}
