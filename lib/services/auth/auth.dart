import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waregraph/services/api/firebase/firebase.dart';
import 'package:waregraph/services/api/user.dart';
import 'package:waregraph/services/data/provider/user_provider.dart';

class AuthServices {
  static final funct = FirebaseFunct();

  static Future<User?> signInWithGoogle() async {
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    // Obtain the auth details from the request
    try {
      final UserCredential userCredential =
          await funct.authInstance.signInWithPopup(authProvider);
      print(userCredential.user!.uid);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> userIsExists(UserProvider userProvider) async {
    try {
      return await UserApi.getOnceUser().then((value) {
        if (value != null) {
          userProvider.userData = value;
          return true;
        } else {
          return false;
        }
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> anonymouslyLogin() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  static Future<void> logout() async {
    funct.authInstance.signOut();
  }
}
