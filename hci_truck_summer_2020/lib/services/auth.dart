import 'package:firebase_auth/firebase_auth.dart';

class  FirebaseAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // Check user loggin
  static Future<bool> checkLoggedUser() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      if (user == null) {
        return false;
      } else {
        return true;
      }
    } catch (ex) {
      print('Error while checking logged user');
      return false;
    }
  }

  // Sign in
  static Future<FirebaseUser> signIn(email, password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (ex) {
      print('Error while checking signing in');
      return null;
    }
  }

  // Sign up
  static Future<FirebaseUser> signUp(email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (ex) {
      print('Error while checking signing up');
      return null;
    }
  }
}
