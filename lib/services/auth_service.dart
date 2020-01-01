import 'package:book_club/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create FireUser obj based on FirebaseUser
  User _fireUserFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            name: user.displayName,
          )
        : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_fireUserFromFirebaseUser);
    // same as .map((FirebaseUser user) => _fireUserFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _fireUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser firebaseUser = authResult.user;

    assert(!firebaseUser.isAnonymous);
    assert(await firebaseUser.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);

    return User(uid: firebaseUser.uid);
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
