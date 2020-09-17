import 'package:anony_chat/provider/register_provider.dart';
import 'package:anony_chat/routes.dart';
import 'package:anony_chat/ui/view/home/main_home_page.dart';
import 'package:anony_chat/ui/view/intro/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => RegisterProvider()),
  ], child: AnonymousChat()));
}

class AnonymousChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      theme: ThemeData(
          fontFamily: 'Roboto',
          brightness: Brightness.light,
          buttonColor: Colors.indigo,
          primarySwatch: Colors.indigo,
          accentColor: Colors.indigoAccent),
      home: _route() ? MainPage() : IntroPage(),
      routes: routes,
    );
  }

  bool _route() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? true : false;
  }
}
