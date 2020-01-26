import 'package:book_club/models/club.dart';
import 'package:book_club/models/firestore_schema.dart';
import 'package:book_club/models/user.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:book_club/services/auth_service.dart';
import 'package:book_club/services/flirestore_service.dart';

/*
LOGIN
*/
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
      if (user != null) {
        print('user is not null: ' + user.toString());
        store.dispatch(new LoginSuccessAction(user));
      } else {
        print('user is null');
        store.dispatch(new LoginFailedAction());
      }
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

/*
CLUB
*/
ThunkAction createClub(FireClub club, User user) {
  final FirestoreService _firestore = FirestoreService();
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingClubAction());
      dynamic newClub = _firestore.createClub(club, user);
      store.dispatch(new CreateClubSuccessAction(club: newClub));
    });
  };
}

class StartLoadingClubAction {
  StartLoadingClubAction();
}

class GetClubSuccessAction {
  final Club club;
  GetClubSuccessAction({this.club});
}

class CreateClubSuccessAction {
  final Club club;
  CreateClubSuccessAction({this.club});
}

class UpdateClubSuccessAction {
  final Club club;
  UpdateClubSuccessAction({this.club});
}
