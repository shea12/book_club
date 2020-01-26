import 'package:redux/redux.dart';
import 'package:book_club/store/state.dart';
import 'package:book_club/store/actions.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    loginState: loginReducer(state.loginState, action),
    clubState: clubReducer(state.clubState, action)
  );
}

/*
LOGIN
*/
final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, StartLoadingAction>(_startLoading),
  TypedReducer<LoginState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<LoginState, LoginFailedAction>(_loginFailed),
  TypedReducer<LoginState, LogoutSuccessAction>(_logoutSuccess),
  TypedReducer<LoginState, LogoutFailedAction>(_logoutFailed),
]);

LoginState _startLoading(LoginState state, StartLoadingAction action) {
  return state.copyWith(isLoading: true, error: false);
}

LoginState _loginSuccess(LoginState state, LoginSuccessAction action) {
  return state.copyWith(user: action.user, isLoading: false, error: false);
}

LoginState _loginFailed(LoginState state, LoginFailedAction action) {
  return state.copyWith(user: null, isLoading: false, error: true);
}

LoginState _logoutSuccess(LoginState state, LogoutSuccessAction action) {
  return state.copyWith(user: null, isLoading: false, error: false);
}

LoginState _logoutFailed(LoginState state, LogoutFailedAction action) {
  return state.copyWith(isLoading: false, error: true);
}

/*
CLUB
*/
final clubReducer = combineReducers<ClubState>([
  TypedReducer<ClubState, StartLoadingClubAction>(_startLoadingClub),
  TypedReducer<ClubState, GetClubSuccessAction>(_getClubSuccess),
  TypedReducer<ClubState, CreateClubSuccessAction>(_createClubSuccess),
  TypedReducer<ClubState, UpdateClubSuccessAction>(_updateClubSuccess),
]);

ClubState _startLoadingClub(ClubState state, StartLoadingClubAction action) {
  return state.copyWith(isLoading: true, error: false);
}

ClubState _getClubSuccess(ClubState state, GetClubSuccessAction action) {
  return state.copyWith(club: action.club, isLoading: true, error: false);
}

ClubState _createClubSuccess(ClubState state, CreateClubSuccessAction action) {
  return state.copyWith(club: action.club, isLoading: true, error: false);
}

ClubState _updateClubSuccess(ClubState state, UpdateClubSuccessAction action) {
  return state.copyWith(club: action.club, isLoading: true, error: false);
}
