import 'dart:async';

import 'package:cigarette_control/smokes_repository_core/smoke_repository_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth auth;

  const FirebaseUserRepository(this.auth);

  @override
  Future<UserEntity> login() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await auth.signInWithCredential(credential)).user;

    return UserEntity(user.uid, user.displayName, user.photoUrl, user.email);
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }
}
