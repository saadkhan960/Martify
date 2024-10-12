import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/Model/user_model.dart';

class UserRepository {
  static final _db = FirebaseFirestore.instance;

  // Method to save user data to FireStore
  static Future<void> saveUserRecord({required UserModel user}) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exection: $e");
      }
      throw "Firebase Exection: $e";
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw "Format Exception: $e";
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw "Platform Exception: $e";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Something Went Wrong. Please Try Again \n Error: $e";
    }
  }

// -----------In App Profile CRUD----------------------------------

  //Fetch user details based on user ID
  static Future<UserModel> fetchUserDetails() async {
    try {
      final String userId = AuthenticationRepository.getUserId();
      final documentSnapshot = await _db.collection("Users").doc(userId).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exection: $e");
      }
      throw "Firebase Exection: $e";
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw "Format Exception: $e";
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw "Platform Exception: $e";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Something Went Wrong. Please Try Again \n Error: $e";
    }
  }

  //function to update user data in firestore
  static Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exection: $e");
      }
      throw "Firebase Exection: $e";
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw "Format Exception: $e";
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw "Platform Exception: $e";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Something Went Wrong. Please Try Again \n Error: $e";
    }
  }

  //function to update any  Specific field of user in collection
  static Future<void> updateSingleField(Map<String, dynamic> json) async {
    final String userId = AuthenticationRepository.getUserId();
    try {
      await _db.collection("Users").doc(userId).update(json);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exection: $e");
      }
      throw "Firebase Exection: $e";
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw "Format Exception: $e";
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw "Platform Exception: $e";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Something Went Wrong. Please Try Again \n Error: $e";
    }
  }

  //function to remove user data from firestore
  static Future<void> removeUserData(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exection: $e");
      }
      throw "Firebase Exection: $e";
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw "Format Exception: $e";
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw "Platform Exception: $e";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Something Went Wrong. Please Try Again \n Error: $e";
    }
  }

  //Upload user profile picture
  static Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exection: $e");
      }
      throw "Firebase Exection: $e";
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw "Format Exception: $e";
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw "Platform Exception: $e";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Something Went Wrong. Please Try Again \n Error: $e";
    }
  }
}
