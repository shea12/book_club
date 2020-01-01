import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_club/store/state.dart';
import 'package:book_club/services/auth_service.dart';
import 'package:book_club/store/actions.dart';
import 'package:book_club/models/user.dart';

class GoogleAuth extends StatefulWidget {
  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
          body: Container(
            color: CupertinoColors.darkBackgroundGray,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('BookClub',
                      style: TextStyle(
                          color: CupertinoColors.systemYellow, fontSize: 40.0)),
                  SizedBox(height: 50),
                  _signInButton(viewModel),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _signInButton(_ViewModel viewModel) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        await viewModel.signIn();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function() signIn;
  _ViewModel({this.signIn});

  factory _ViewModel.create(Store<AppState> store) {
    final AuthService _authSvc = AuthService();
    return _ViewModel(
      signIn: () async {
        User user = await _authSvc.signInWithGoogle();
        store.dispatch(SetUserAction(user));
      },
    );
  }
}
