import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:book_club/store/reducers.dart';
import 'package:book_club/store/state.dart';
import 'package:book_club/routes.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:book_club/store/actions.dart';

void main() => runApp(BookClub());

class BookClub extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    store.dispatch(checkLoginStatus());
    return StoreProvider(
      store: this.store,
      child: CupertinoApp(
        title: 'BookClub',
        theme: CupertinoThemeData(primaryColor: CupertinoColors.black),
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
