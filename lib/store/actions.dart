import 'package:book_club/models/club.dart';
import 'package:book_club/models/user.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:book_club/services/auth_service.dart';

ThunkAction checkLoginStatus() {
  final AuthService _authSvc = AuthService();
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      User user = await _authSvc.checkLoginStatus();
      if (user != null) store.dispatch(new LoginSuccessAction(user));
    });
  };
}

ThunkAction loginUser() {
  final AuthService _authSvc = AuthService();
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      User user = await _authSvc.signInWithGoogle();
      if (user != null) store.dispatch(new LoginSuccessAction(user));
      else store.dispatch(new LoginFailedAction()); 
    });
  };
}

ThunkAction logoutUser() {
  final AuthService _authSvc = AuthService();
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      await _authSvc.signOut();
      store.dispatch(new LogoutSuccessAction());
    });
  };
}

class StartLoadingAction {
  StartLoadingAction();
}

class LoginSuccessAction {
  final User user;
  LoginSuccessAction(this.user);
}

class LoginFailedAction {
  LoginFailedAction();
}

class LogoutSuccessAction {
  LogoutSuccessAction();
}

class LogoutFailedAction {
  LogoutFailedAction();
}

class StartLoadingClubAction {
  StartLoadingClubAction();
}

class GetClubAction {
  final Club club;
  GetClubAction({this.club});
}

class CreateClubAction {
  final Club club;
  CreateClubAction({this.club});
}

class UpdateClubAction {
  final Club club;
  UpdateClubAction({this.club});
}
