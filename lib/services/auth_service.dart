import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final usercredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final _auth =
        await FirebaseAuth.instance.signInWithCredential(usercredential);

    FirebaseFirestore.instance.collection("users").doc(_auth.user!.email).set({
      "email": _auth.user!.email,
      "uid": _auth.user!.uid,
      "username": _auth.user!.email!.split("@")[0],
      "bio": "empty bio",
    });

    return _auth;
  }

  signInWithGithub() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final Credential = await _auth.signInWithProvider(GithubAuthProvider());
      FirebaseFirestore.instance
          .collection("users")
          .doc(Credential.user!.email)
          .set({
        "email": Credential.user!.email,
        "uid": Credential.user!.uid,
        "username": Credential.user!.email!.split("@")[0],
        "bio": "empty bio",
      });
      return Credential;
    } catch (e) {
      return e.toString();
    }
  }
}
