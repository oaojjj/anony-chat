import 'package:flutter/material.dart';

import 'ui/widget/intro_page.dart';

void main() => runApp(AnonymousChat());

class AnonymousChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Chat',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: IntroPage(),
    );
  }
}



