import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_club/models/viewModels/user.dart';
import 'package:book_club/models/viewModels/club.dart';
import 'package:book_club/screens/auth/google_auth.dart';
import 'package:book_club/store/state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:book_club/store/actions.dart';

Firestore db = Firestore.instance;

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.user == null) return GoogleAuth();
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.systemYellow,
              middle: Title(
                color: CupertinoColors.black,
                child: Text('Account', style: TextStyle(fontSize: 20.0)),
              ),
              trailing: GestureDetector(
                onTap: () async {},
                child: Icon(
                  CupertinoIcons.pen,
                  color: CupertinoColors.black,
                  size: 25.0,
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: StreamBuilder(
                    stream: db
                        .collection('users')
                        .document(vm.user.documentID)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> s) {
                      if (!s.hasData) return CupertinoActivityIndicator();
                      return UserDataView(doc: s.data);
                    },
                  ),
                ),
                Container(
                  child: StreamBuilder(
                    stream: _getClubsStream(vm.clubs),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> s) {
                      if (!s.hasData) return CupertinoActivityIndicator();
                      return ClubsDataView(docs: s.data.documents);
                    },
                  ),
                )
              ],
            ),
          );
        },
      );

  Stream<QuerySnapshot> _getClubsStream(List<Club> clubs) {
    return db.collection('clubs').snapshots();
  }
}

class ClubsDataView extends StatelessWidget {
  final List<DocumentSnapshot> docs;
  ClubsDataView({this.docs});

  @override
  Widget build(BuildContext context) {
    if (docs.length <= 0) return Container(child: Text("No clubs found"));

    String name = docs[0]['name'].toString();
    String secret = docs[0]['secret'].toString();

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(name, style: TextStyle(fontSize: 20.0)),
            Text(secret, style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }
}

class UserDataView extends StatelessWidget {
  final DocumentSnapshot doc;
  UserDataView({this.doc});

  @override
  Widget build(BuildContext context) {
    if (!doc.exists) return Container(child: Text("No user found"));

    String name = doc['name'].toString();
    String email = doc['email'].toString();

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(name, style: TextStyle(fontSize: 20.0)),
            Text(email, style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final User user;
  final bool isLoading;
  final bool hasError;
  final List<Club> clubs;
  final Function() logout;

  _ViewModel(
      {this.user, this.isLoading, this.hasError, this.clubs, this.logout});

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      user: store.state.loginState.user,
      isLoading: store.state.loginState.isLoading,
      hasError: store.state.loginState.error,
      clubs: store.state.clubState.clubs,
      logout: () async {
        store.dispatch(logoutUser());
      },
    );
  }
}
