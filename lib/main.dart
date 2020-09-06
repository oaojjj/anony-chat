import 'package:anony_chat/routes.dart';
import 'package:anony_chat/ui/view/home/main_home_page.dart';
import 'package:anony_chat/ui/view/intro/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AnonymousChat());
}

class AnonymousChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      theme: ThemeData(
          primarySwatch: Colors.amber, accentColor: Colors.amberAccent),
      home: _route() ? MainPage() : IntroPage(),
      routes: routes,
    );
  }

  bool _route() {
    FirebaseAuth mAuth = FirebaseAuth.instance;
    User currentUser = mAuth.currentUser;
    return currentUser != null ? true : false;
  }
}
