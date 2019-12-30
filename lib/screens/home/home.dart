import 'package:book_club/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemYellow,
            middle: Title(
                color: CupertinoColors.black, child: Text('Book Club Home')),
            trailing: GestureDetector(
                onTap: () async {
                  await _auth.signOut();
                },
                child: Text('Log out'))),
        child: Center(child: Text('Home!')));
  }
}

/*
trailing: GestureDetector(
    onTap: () {
      debugPrint('add icon tapped'));
    },
    child: Icon(
      CupertinoIcons.add,
      color: CupertinoColors.black,
    ),
  ),
*/
