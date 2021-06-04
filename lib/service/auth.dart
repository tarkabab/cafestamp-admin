import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> register(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (exception.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (exception) {
      print(exception);
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('user: $userCredential');
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (exception.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? getUser() => _auth.currentUser;
}

// FirebaseAuth.instance
//   .authStateChanges()
//   .listen((User user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });