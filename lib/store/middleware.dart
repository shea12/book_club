import 'dart:async';
import 'package:redux/redux.dart';
import 'package:book_club/store/actions.dart';
import 'package:book_club/store/state.dart';

List<Middleware<AppState>> createStoreMiddleware() => [
      TypedMiddleware<AppState, SetClubAction>(_createClub),
    ];

Future _createClub(
    Store<AppState> store, SetClubAction action, NextDispatcher next) async {
  await Future.sync(
      () => Duration(seconds: 3)); // Simulate saving the list to disk
  next(action);
}
