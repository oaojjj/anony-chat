import 'package:anony_chat/provider/member_auth_provider.dart';
import 'package:anony_chat/ui/view/home/main_home_page.dart';
import 'package:anony_chat/ui/view/intro/intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  AuthStatus _authStatus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authProvider = Provider.of<MemberAuthProvider>(context);
    _authStatus = authProvider.onStartUp();
  }

  @override
  Widget build(BuildContext context) {
    return _route();
  }

  // 사용자가 회원가입을 했다면 다음 앱에 접속시에도 메인페이지(자동로그인)
  Widget _route() {
    final user = FirebaseAuth.instance.currentUser;
    print('user: $user\nauthStatus: $_authStatus');
    
    if (user != null || _authStatus == AuthStatus.registered) {
      return MainPage();
    } else {
      // 회원가입 진행
      return IntroPage();
    }
  }
}
