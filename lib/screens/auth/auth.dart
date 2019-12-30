import 'package:book_club/screens/auth/register.dart';
import 'package:book_club/screens/auth/sign_in.dart';
import 'package:flutter/cupertino.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showLogin = true;
  void toggleLoginState()  {
    setState(() => showLogin  = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) return SignIn(toggleLoginState: toggleLoginState);
    return Register(toggleLoginState: toggleLoginState);
  }
}