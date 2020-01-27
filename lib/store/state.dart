import 'package:book_club/models/club.dart';
import 'package:book_club/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final LoginState loginState;
  final ClubState clubState;

  AppState({@required this.loginState, this.clubState});

  factory AppState.initial() {
    return AppState(
      loginState: LoginState.initial(),
      clubState: ClubState.initial(),
    );
  }

  AppState copyWith({LoginState loginState, ClubState clubState}) {
    return AppState(
      loginState: loginState ?? this.loginState,
      clubState: clubState ?? this.clubState,
    );
  }

  @override
  int get hashCode => loginState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
        loginState == other.loginState &&
        clubState == other.clubState;
}

/*
LOGIN
*/
@immutable
class LoginState {
  final User user;
  final bool isLoading;
  final bool error;

  LoginState({
    @required this.user,
    @required this.isLoading,
    @required this.error,
  });

  factory LoginState.initial() {
    return new LoginState(
      user: null,
      isLoading: false,
      error: false,
    );
  }

  LoginState copyWith({User user, bool isLoading, bool error}) {
    return new LoginState(
      user: user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          error == other.error &&
          user == other.user;

  @override
  int get hashCode => isLoading.hashCode ^ user.hashCode;
}

/*
CLUB
*/
@immutable
class ClubState {
  final List<Club> clubs;
  final Club club;
  final bool isLoading;
  final bool error;

  ClubState({
    this.clubs,
    this.club,
    @required this.isLoading,
    @required this.error,
  });

  factory ClubState.initial() {
    return new ClubState(
      clubs: null,
      club: null,
      isLoading: false,
      error: false,
    );
  }

  ClubState copyWith({List<Club> clubs, Club club, bool isLoading, bool error}) {
    return new ClubState(
      clubs: clubs,
      club: club,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClubState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          error == other.error &&
          club == other.club &&
          clubs == other.clubs;

  @override
  int get hashCode => isLoading.hashCode ^ club.hashCode;
}
