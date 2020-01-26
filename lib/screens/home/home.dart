import 'package:book_club/models/user.dart';
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
      builder: (BuildContext context, _ViewModel viewModel) {
        if (viewModel.user == null) return GoogleAuth();
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemYellow,
            middle: Title(
              color: CupertinoColors.black,
              child: Text('BookClub'),
            ),
            trailing: GestureDetector(
              onTap: () async {
                viewModel.logout();
              },
              child: Icon(
                CupertinoIcons.settings,
                color: CupertinoColors.black,
              ),
            ),
          ),
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
                        borderRadius: new BorderRadius.all(
                          new Radius.circular(20.0),
                        ),
                      ),
                      child: new Center(
                        child: new Text(
                          'Welcome ' + viewModel.user.name,
                          style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
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
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                height: 300,
                decoration: new BoxDecoration(
                  color: CupertinoColors.activeGreen,
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(20.0),
                  ),
                ),
                child: new Center(
                  child: new Text(
                    '',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

class _ViewModel {
  final User user;
  final bool isLoading;
  final bool hasError;
  final Function() logout;

  _ViewModel({this.user, this.isLoading, this.hasError, this.logout});

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      user: store.state.loginState.user,
      isLoading: store.state.loginState.isLoading,
      hasError: store.state.loginState.error,
      logout: () async {
        store.dispatch(logoutUser());
      },
    );
  }
}
