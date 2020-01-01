import 'package:book_club/models/user.dart';
import 'package:book_club/screens/auth/google_auth.dart';
import 'package:book_club/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) return Home();
    return GoogleAuth();
  }
}
