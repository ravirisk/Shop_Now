import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_now/constant/app_constant.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User get user => _auth.currentUser!;

  Future<String?> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
     user.updateDisplayName(name);
     setLoginStatus();

      return null;
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
         return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      // Displaying the usual firebase error message
    }
    return null;
  }

  Future<String?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      // Displaying the error message
      return e.toString();
    }
    return null;
  }

  setLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstant.loginKey, true);
  }

  getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool(AppConstant.loginKey) ?? false;
    return status;
  }
}
