import 'package:anony_chat/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
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
      routes: routes,
    );
  }
}
