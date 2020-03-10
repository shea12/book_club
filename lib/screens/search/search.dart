import 'package:book_club/models/viewModels/user.dart';
import 'package:book_club/models/viewModels/club.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_club/store/state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:book_club/store/actions.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel vm) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.systemYellow,
              middle: Title(
                color: CupertinoColors.black,
                child: Text('BookClub'),
              ),
              trailing: GestureDetector(
                onTap: () async {
                  vm.logout();
                },
                child: Icon(
                  CupertinoIcons.settings,
                  color: CupertinoColors.black,
                ),
              ),
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: CupertinoColors.activeGreen,
                        child: Text('Grid Item $index'),
                      );
                    },
                    childCount: 20,
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: CupertinoColors.activeBlue,
                        child: Text('List Item $index'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class _ViewModel {
  final User user;
  final bool isLoading;
  final bool hasError;
  final List<Club> clubs;
  final Function() logout;

  _ViewModel(
      {this.user, this.isLoading, this.hasError, this.clubs, this.logout});

  factory _ViewModel.create(Store<AppState> store) {
    return _ViewModel(
      user: store.state.loginState.user,
      isLoading: store.state.loginState.isLoading,
      hasError: store.state.loginState.error,
      clubs: store.state.clubState.clubs,
      logout: () async {
        store.dispatch(logoutUser());
      },
    );
  }
}
