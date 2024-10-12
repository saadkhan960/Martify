import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:martify/Data/repository.user/user_repository.dart';
import 'package:martify/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:martify/utils/exceptions/firebase_exceptions.dart';
import 'package:martify/utils/exceptions/format_exceptions.dart';
import 'package:martify/utils/exceptions/platform_exceptions.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/loginScreen/login_screen.dart';

class AuthenticationRepository {
  static final _auth = FirebaseAuth.instance;

// ------- Firebase Registration-----
  static Future<UserCredential> registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Update display name after successful registration
      await credential.user!.updateDisplayName(displayName);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

// -----------Mail Verfication----------------

  static Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

  // ------------Logout User -----------
  static Future<void> logoutUserFirebase(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      MHelperFunctions.mostStrictAnimationNavigation(
          context, const LoginScreen());
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

// ---------------Login With Email And Password-------------------

  static Future<UserCredential> loginWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

  // ---------------Sign In With Google-------------------

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //get the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      ///Create a new Credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //Once signed in return the usercreatial
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

  //Get login user id
  static String getUserId() {
    try {
      return _auth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

  // Get user email
  static String getUserEmail() {
    try {
      return _auth.currentUser!.email!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

  // ---------------FORGET PASSWORD -- Reset Password With Email And Password-------------------

  static Future<void> resetPassWithEmailAndPassword(
      {required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }
  // ---------------Re Authenticate User with email and password-------------------

  static Future<void> reAuthenticateWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      //Reauthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

  // ---------------Delete user Account-------------------

  static Future<void> deleteAccount() async {
    try {
      await UserRepository.removeUserData(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }

  // ---------------verifyBeforeUpdateEmail -------------------

  static Future<void> verifyBeforeUpdateEmail(String newEmail) async {
    try {
      await _auth.currentUser!.verifyBeforeUpdateEmail(newEmail);
      // if(_auth.currentUser!.)
      // await _auth.currentUser!.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }
  // ---------------updateEmail -------------------

  static Future<void> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser!.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }
  // ---------------updatePassword -------------------

  static Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Auth Firebase Exection: $e");
      }
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(" Firebase Exection: $e");
      }
      throw MFirebaseException(e.code).message;
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw const MFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw MPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      throw "Something Went Wrong. Please Try Again";
    }
  }
}
