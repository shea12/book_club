import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:book_club/store/actions.dart';
import 'package:book_club/store/state.dart';
import 'package:book_club/models/user.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) =>
            Center(child: _createWidget(viewModel.user)),
      );

  Widget _createWidget(_UserViewModel uvm) {
    if (uvm is _NoUserViewModel) {
      return _createNoUserWidget(uvm);
    } else {
      return _createHasUserWidget(uvm);
    }
  }

  Widget _createNoUserWidget(_NoUserViewModel vm) => Column(
        children: [
          Text(vm.hint),
          CupertinoButton(
              onPressed: () {
                // vm.login(User(1, 'carshea@icloud.com', 'Caroline', 'Shea'));
              },
              child: Text('log me in!'))
        ],
      );

  Widget _createHasUserWidget(_HasUserViewModel vm) => Column(
        children: [
          Text(vm.user.email),
          Text(vm.user.firstName),
          Text(vm.user.lastName),
          CupertinoButton(
              onPressed: () {
                vm.logout(null);
              },
              child: Text('log me out!'))
        ],
      );
}

class _ViewModel {
  final String pageTitle;
  final _UserViewModel user;

  _ViewModel(this.pageTitle, this.user);

  factory _ViewModel.create(Store<AppState> store) {
    _UserViewModel user = _HasUserViewModel(store.state.user, (User user) {
      store.dispatch(SetUserAction(null));
    });

    if (store.state.user == null) {
      user = _NoUserViewModel("You are not logged in", (User user) {
        store.dispatch(SetUserAction(user));
      });
    }

    return _ViewModel('Current User', user);
  }
}

abstract class _UserViewModel {}

@immutable
class _NoUserViewModel extends _UserViewModel {
  final String hint;
  final Function(User) login;
  _NoUserViewModel(this.hint, this.login);
}

@immutable
class _HasUserViewModel extends _UserViewModel {
  final User user;
  final Function(User) logout;
  _HasUserViewModel(this.user, this.logout);
}
