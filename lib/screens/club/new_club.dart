import 'package:book_club/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_club/styles/styles.dart';
import 'package:book_club/services/flirestore_service.dart';
import 'package:provider/provider.dart';
import 'package:book_club/models/user.dart';
import 'package:book_club/models/firestore_schema.dart';

class NewClub extends StatefulWidget {
  @override
  _NewClubState createState() => _NewClubState();
}

class _NewClubState extends State<NewClub> {
  FirestoreService _firestore = FirestoreService();
  String name = '';
  String secret = '';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: _createScreen(),
    );
  }

  _createScreen() {
    final user = Provider.of<User>(context);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemYellow,
        middle: Text(
          'New Club',
          style: TextStyle(color: CupertinoColors.black),
        ),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text('Create a New Club', style: Styles.headerText),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 300,
              child: CupertinoTextField(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                clearButtonMode: OverlayVisibilityMode.editing,
                autocorrect: false,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0,
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ),
                placeholder: 'Name',
                onChanged: (newName) {
                  setState(() {
                    name = newName;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 300,
              child: CupertinoTextField(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                clearButtonMode: OverlayVisibilityMode.editing,
                autocorrect: false,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0,
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ),
                placeholder: 'Secret',
                onChanged: (newSecret) {
                  setState(() {
                    secret = newSecret;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            CupertinoButton(
              color: CupertinoColors.systemGreen,
              child: Text('Create Club!', style: TextStyle()),
              onPressed: () {
                FireClub club = FireClub(name: name, secret: secret);
                _firestore.createClub(club, user);
              },
            )
          ],
        ),
      ),
    );
  }
}
