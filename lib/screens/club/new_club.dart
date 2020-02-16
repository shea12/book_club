import 'package:flutter/cupertino.dart';
import 'package:book_club/styles/styles.dart';
import 'package:book_club/models/viewModels/user.dart';
import 'package:book_club/models/viewModels/club.dart';
import 'package:book_club/screens/auth/google_auth.dart';
import 'package:book_club/store/state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:book_club/store/actions.dart';

class NewClub extends StatefulWidget {
  @override
  _NewClubState createState() => _NewClubState();
}

class _NewClubState extends State<NewClub> {
  String name = '';
  String secret = '';

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.user == null) return GoogleAuth();
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
                    Club club = Club(name: name, secret: secret);
                    vm.createNewClub(club);
                  },
                )
              ],
            ),
          ),
        );
      });
}

class _ViewModel {
  final User user;
  final bool isLoading;
  final bool hasError;
  final Function(Club club) createNewClub;

  _ViewModel({this.user, this.isLoading, this.hasError, this.createNewClub});

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      user: store.state.loginState.user,
      isLoading: store.state.loginState.isLoading,
      hasError: store.state.loginState.error,
      createNewClub: (club) async {
        store.dispatch(createClub(club, store.state.loginState.user));
      },
    );
  }
}
