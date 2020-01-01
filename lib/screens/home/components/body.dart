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
            Center(child: _createWidget(viewModel)),
      );

  Widget _createWidget(_ViewModel vm) {
    if (vm.user == null) return _createNoUserWidget(vm);
    return _createHasUserWidget(vm);
  }

  Widget _createNoUserWidget(_ViewModel vm) => Column(
        children: [
          Text(vm.hint),
          CupertinoButton(
              onPressed: () {
                // vm.login(User(1, 'carshea@icloud.com', 'Caroline', 'Shea'));
              },
              child: Text('log me in!'))
        ],
      );

  Widget _createHasUserWidget(_ViewModel vm) => Column(
        children: [
          Text(vm.user.email),
          Text(vm.user.name),
          CupertinoButton(
              onPressed: () {
                vm.logout(null);
              },
              child: Text('log me out!'))
        ],
      );
}

class _ViewModel {
  final User user;
  final String hint;
  final Function(User) login;
  final Function(User) logout;

  _ViewModel({this.user, this.hint, this.login, this.logout});

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      user: store.state.user,
      hint: "You are not logged in",
      login: (User user) => store.dispatch(SetUserAction(user)),
      logout: (User user) => store.dispatch(SetUserAction(null)),
    );
  }
}
