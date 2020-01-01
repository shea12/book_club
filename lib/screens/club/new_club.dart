import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:book_club/styles/styles.dart';
import 'package:book_club/services/flirestore_service.dart';
import 'package:book_club/models/firestore_schema.dart';
import 'package:book_club/store/state.dart';

class NewClub extends StatefulWidget {
  @override
  _NewClubState createState() => _NewClubState();
}

class _NewClubState extends State<NewClub> {
  String name = '';
  String secret = '';

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) =>
            CupertinoPageScaffold(
          backgroundColor: CupertinoColors.white,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemYellow,
            middle: Text(
              'New Club',
              style: TextStyle(color: CupertinoColors.black),
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text('Create a New Club', style: Styles.headerText),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: CupertinoTextField(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    autocorrect: false,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0,
                          color: CupertinoColors.inactiveGray,
                        ),
                      ),
                    ),
                    placeholder: 'Name',
                    onChanged: (newName) {
                      setState(() {
                        name = newName;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: CupertinoTextField(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    autocorrect: false,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0,
                          color: CupertinoColors.inactiveGray,
                        ),
                      ),
                    ),
                    placeholder: 'Secret',
                    onChanged: (newSecret) {
                      setState(() {
                        secret = newSecret;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  color: CupertinoColors.systemGreen,
                  child: Text('Create Club!', style: TextStyle()),
                  onPressed: () {
                    Club club = Club(name: name, secret: secret);
                    viewModel.createClub(club);
                  },
                )
              ],
            ),
          ),
        ),
      );
}

class _ViewModel {
  final Function(Club) createClub;
  _ViewModel({this.createClub});

  factory _ViewModel.create(Store<AppState> store) {
    FirestoreService _firestore = FirestoreService();
    User user = User(
      uid: store.state.user?.uid,
      name: store.state.user.name,
      email: store.state.user.email,
    );
    return _ViewModel(
      createClub: (Club club) => _firestore.createClub(club, user),
    );
  }
}
