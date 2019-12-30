import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:book_club/store/middleware.dart';
import 'package:book_club/store/reducers.dart';
import 'package:book_club/store/state.dart';
import 'package:book_club/routes.dart';

void main() => runApp(ToDoListApp());

class ToDoListApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: createStoreMiddleware(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
        store: this.store,
        child: CupertinoApp(
          title: 'Book Club',
          theme: CupertinoThemeData(primaryColor: CupertinoColors.black),
          initialRoute: '/',
          routes: routes,
        ),
      );
}