// import 'dart:async';
// import 'package:redux/redux.dart';
// import 'package:book_club/store/actions.dart';
// import 'package:book_club/store/state.dart';

// List<Middleware<AppState>> createStoreMiddleware() => [
//   TypedMiddleware<AppState, SetClubAction>(_createClub),
// ];

// Future _createClub(Store<AppState> store, SetClubAction action, NextDispatcher next) async {
//   print('in here before');
//   await Future.sync(() => Duration(seconds: 3),);
//   next(action);
//   print('in here after');
// }
