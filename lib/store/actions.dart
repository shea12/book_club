import 'package:book_club/models/viewModels/club.dart';
import 'package:book_club/models/viewModels/user.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:book_club/services/auth_service.dart';
import 'package:book_club/services/firestore_service.dart';

/*
LOGIN
*/
ThunkAction checkLoginStatus() {
  final AuthService _authSvc = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      User user = await _authSvc.checkLoginStatus();
      if (user != null) {
        store.dispatch(new LoginSuccessAction(user));
        List<Club> clubs = await _firestoreService.getClubsForUser(user);
        store.dispatch(new GetAllClubsSuccessAction(clubs));
      }
    });
  };
}

ThunkAction loginUser() {
  final AuthService _authSvc = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      User user = await _authSvc.signInWithGoogle();
      if (user != null) {
        store.dispatch(new LoginSuccessAction(user));
        List<Club> clubs = await _firestoreService.getClubsForUser(user);
        store.dispatch(new GetAllClubsSuccessAction(clubs));
      } else {
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
ThunkAction createClub(Club club, User user) {
  final FirestoreService _firestore = FirestoreService();
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingClubAction());
      await _firestore.createClub(club, user);
      store.dispatch(new CreateClubSuccessAction(club: club));
    });
  };
}

class StartLoadingClubAction {
  StartLoadingClubAction();
}

class GetAllClubsSuccessAction {
  final List<Club> clubs;
  GetAllClubsSuccessAction(this.clubs);
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
