import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_club/models/viewModels/user.dart';
import 'package:book_club/models/viewModels/club.dart';

class FirestoreService {
  static final Firestore db = Firestore.instance;
  var usersRef = db.collection('users');
  var clubsRef = db.collection('clubs');

  void getData() {
    db
        .collection('clubs')
        .document('test_1234')
        .collection('members')
        .getDocuments()
        .then((QuerySnapshot val) {
      print(val.documents.length);
      val.documents.forEach((DocumentSnapshot ds) {
        print(ds.data);
      });
    });
  }

  User _getUserFromSnapshot(DocumentSnapshot snap) {
    User user = User(
      uid: snap.data['uid'],
      name: snap.data['name'],
      email: snap.data['email'],
      dateUpdated: DateTime.parse(snap.data['dateUpdated'].toDate().toString()),
      dateCreated: DateTime.parse(snap.data['dateCreated'].toDate().toString()),
      clubIds: List<String>.from(snap.data['clubIds']),
      documentID: snap.documentID
    );
    return user;
  }

  Future<User> getUser(User user) async {
    QuerySnapshot query = await usersRef.where('uid', isEqualTo: user.uid).getDocuments();
    if (query.documents.length == 0) return null;
    if (query.documents.length > 1) return null;
    return _getUserFromSnapshot(query.documents[0]);
  }

  Future<User> createUser(User user) async {
    user.dateCreated = DateTime.now();
    user.dateUpdated = DateTime.now();
    user.clubIds = new List<String>();
    db.collection('users').document(user.uid).setData(user.toJson());
    return user;
  }

  Future<void> updateUser(User user) async {
    user.dateUpdated = DateTime.now();
    await db
        .collection("users")
        .document(user.documentID)
        .updateData(user.toJson());
  }

  Future<List<Club>> getClubsForUser(User user) async {
    List<Club> clubs = List<Club>();
    if (user.clubIds == null) return null;
    for (int i = 0; i < user.clubIds.length; i++) {
      DocumentSnapshot snap =
          await db.collection('clubs').document(user.clubIds[i]).get();
      clubs.add(_getClubFromSnapshot(snap));
    }
    return clubs;
  }

  Club _getClubFromSnapshot(DocumentSnapshot snap) {
    Club club = Club(
        name: snap.data['name'],
        secret: snap.data['secret'],
        dateCreated: snap.data['dateCreated']);
    return club;
  }

  Future<void> createClub(Club club, User user) async {
    club.dateCreated = DateTime.now();
    DocumentReference clubDoc = await db.collection("clubs").add(club.toJson());
    await clubsRef
        .document(clubDoc.documentID)
        .collection('members')
        .add({'uid': user.uid, 'joined': DateTime.now()});
    await clubsRef
        .document(clubDoc.documentID)
        .collection('privateData')
        .add({'admin': user.uid});
    user.clubIds.add(clubDoc.documentID);
    await usersRef.document(user.documentID).updateData(user.toJson());
  }
}
