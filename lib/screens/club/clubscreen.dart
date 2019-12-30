import 'package:flutter/cupertino.dart';
import 'package:book_club/screens/club/components/body.dart';

class ClubScreen extends StatefulWidget {
  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemYellow,
          middle: Title(
            color: CupertinoColors.black,
            child: Text('Club')
          ),
        ),
        child: Body(),
      ),
    );
  }
}