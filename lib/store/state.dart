import 'package:book_club/models/club.dart';

class AppState {
  final Club club;

  AppState(
    this.club,
  );

  factory AppState.initial() => AppState(null);
}
