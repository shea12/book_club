import 'package:book_club/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_club/services/flirestore_service.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    FirestoreService _fsSvc = FirestoreService();
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemYellow,
            middle:
                Title(color: CupertinoColors.black, child: Text('BookClub')),
            trailing: GestureDetector(
                onTap: () async {
                  await _auth.signOut();
                },
                child: Icon(
                  CupertinoIcons.settings,
                  color: CupertinoColors.black,
                ))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    height: 100,
                    decoration: new BoxDecoration(
                        color: CupertinoColors.systemPurple,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(20.0))),
                    child: new Center(
                      child: new Text('Welcome',
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ))
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.all(20.0),
                height: 150,
                decoration: new BoxDecoration(
                    color: CupertinoColors.systemTeal,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0))),
                child: new Row(children: <Widget>[
                  GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, '/new_club');
                      },
                      child: new Text('New Club  ',
                          style: TextStyle(color: CupertinoColors.white))),
                  Icon(
                    CupertinoIcons.plus_circled,
                    color: CupertinoColors.white,
                  )
                ])),
            Container(
                margin: const EdgeInsets.all(20.0),
                height: 300,
                decoration: new BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0))),
                child: new Center(
                  child: new Text('',
                      style: TextStyle(color: CupertinoColors.white)),
                )),
          ],
        ));
  }
}
