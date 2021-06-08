import 'package:aula09_2021/data/firebase/firebase_database.dart';
import 'package:aula09_2021/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(user.uid) : null;
  }

  Future<UserModel> signInAnonimo() async {
    UserCredential authResult = await _firebaseAuth.signInAnonymously();
    User user = authResult.user;
    // user.
    return UserModel(user.uid);
  }

  signInWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = authResult.user;
    return UserModel(user.uid);
  }

  createUserWithEmailAndPassword(
      {String email, String password, int idade = 21}) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = authResult.user;

    // Invocação ao Firestore para inserir o usuário.
    FirebaseRemoteServer.helper.includeUserData(user.uid, email, idade);
    return UserModel(user.uid);
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }
}
