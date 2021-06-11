import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> register(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (exception) {
// email-already-in-use:
// Thrown if there already exists an account with the given email address.
// invalid-email:
// Thrown if the email address is not valid.
// operation-not-allowed:
// Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.
// weak-password:
// Thrown if the password is not strong enough.
      if (exception.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (exception.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (exception) {
      print(exception);
    }
  }

  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('user: $userCredential');
      // User? user = _auth.currentUser;
      // if (user != null && !user.emailVerified) {
      //   await user.sendEmailVerification();
      // }
      return userCredential;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (exception.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
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