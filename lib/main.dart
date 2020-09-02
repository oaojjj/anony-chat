import 'package:flutter/material.dart';
import 'ui/page/intro_page.dart';

void main() => runApp(AnonymousChat());

class AnonymousChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.amberAccent),
      home: IntroPage(),
    );
  }
}
