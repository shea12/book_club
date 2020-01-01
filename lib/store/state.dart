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

@immutable
class ClubState {
  final Club club;
  final bool isLoading;
  final bool error;

  ClubState({
    @required this.club,
    @required this.isLoading,
    @required this.error,
  });

  factory ClubState.initial() {
    return new ClubState(
      club: null,
      isLoading: false,
      error: false,
    );
  }

  ClubState copyWith({Club club, bool isLoading, bool error}) {
    return new ClubState(
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
          club == other.club;

  @override
  int get hashCode => isLoading.hashCode ^ club.hashCode;
}
