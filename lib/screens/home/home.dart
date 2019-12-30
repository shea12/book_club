import 'package:flutter/cupertino.dart';
import 'package:book_club/screens/home/components/body.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemYellow,
          middle: Title(
            color: CupertinoColors.black,
            child: Text('Book Club App')
          ),
        ),
        child: Body(),
      ),
    );
  }
}
