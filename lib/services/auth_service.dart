import 'package:book_club/models/viewModels/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:book_club/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService _firestoreService = FirestoreService();

  // create FireUser obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            name: user.displayName
          )
        : null;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount gAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication gAuth = await gAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser firebaseUser = authResult.user;

    assert(!firebaseUser.isAnonymous);
    assert(await firebaseUser.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);

    return await _createOrUpdateUser(firebaseUser);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> checkLoginStatus() async {
    try {
      FirebaseUser fireUser = await _auth.currentUser();
      return await _createOrUpdateUser(fireUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> _createOrUpdateUser(FirebaseUser fireUser) async {
    User user = _userFromFirebaseUser(fireUser);
    var existingUser = await _firestoreService.getUser(user);
    if (existingUser == null) {
      return await _firestoreService.createUser(user);
    } else {
      await _firestoreService.updateUser(existingUser);
      return existingUser;
    }
  }
}
