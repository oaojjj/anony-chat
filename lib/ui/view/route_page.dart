import 'package:anony_chat/ui/view/intro/intro_page.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:flutter/material.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route(context);
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : IntroPage();
  }

  bool _route(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // 회원가입
      return false;
    } else {
      return true;
    }
  }
}
