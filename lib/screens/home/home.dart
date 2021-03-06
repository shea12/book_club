import 'package:book_club/models/viewModels/user.dart';
import 'package:book_club/models/viewModels/club.dart';
import 'package:book_club/screens/auth/google_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_club/store/state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:book_club/store/actions.dart';

class Home extends StatelessWidget {
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
                child: Text('BookClub'),
              ),
              trailing: GestureDetector(
                onTap: () async {
                  vm.logout();
                },
                child: Icon(
                  CupertinoIcons.settings,
                  color: CupertinoColors.black,
                ),
              ),
            ),
            child: Column(
              children: <Widget>[_createOrShowClubs(vm, context)],
            ),
          );
        },
      );

  Widget _createOrShowClubs(_ViewModel vm, BuildContext context) {
    if (vm.clubs.length >= 1) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(20.0),
        height: 150,
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(
              new Radius.circular(20.0),
            ),
            border:
                Border.all(color: CupertinoColors.activeOrange, width: 4.0)),
        child: new Row(
          children: <Widget>[
            Text("Current Club: "),
            Row(children: vm.clubs.map((club) => new Text(club.name)).toList())
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(20.0),
        height: 150,
        decoration: new BoxDecoration(
          color: CupertinoColors.systemTeal,
          borderRadius: new BorderRadius.all(
            new Radius.circular(20.0),
          ),
        ),
        child: new Row(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, '/new_club');
              },
              child: new Text(
                'New Club  ',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
            Icon(
              CupertinoIcons.plus_circled,
              color: CupertinoColors.white,
            )
          ],
        ),
      );
    }
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
