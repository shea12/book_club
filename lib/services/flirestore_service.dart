import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_club/models/firestore_schema.dart';
import 'package:book_club/models/user.dart';

class FirestoreService {
  final Firestore _firestore = Firestore.instance;

  void getData() {
    _firestore
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

  DocumentReference createClub(FireClub club, User user) {
    _firestore.collection('clubs').add(club.toJson()).then((DocumentReference dr) {
      _firestore
          .collection('clubs')
          .document(dr.documentID)
          .collection('members')
          .add({'uid': user.uid, 'joined': DateTime.now()});
      _firestore
          .collection('clubs')
          .document(dr.documentID)
          .collection('privateData')
          .add({ 'admin': user.uid });
      return dr;
    });
    return null;
  }
}
