import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/Model/address_model.dart';

class AddressRepo {
  static final _db = FirebaseFirestore.instance;

  static Future<List<AddressModel>> fetchUserAddressess() async {
    try {
      final userId = AuthenticationRepository.getUserId();
      if (userId.isEmpty) {
        throw Exception("Unable to find user Information");
      }

      final result = await _db
          .collection("Users")
          .doc(userId)
          .collection('Addresses')
          .get();

      // Ensure the result is not null and return mapped addresses
      return result.docs.map((documentSnapshot) {
        return AddressModel.fromDocumentSnapshot(documentSnapshot);
      }).toList();
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

  static Future<AddressModel> addAddress(
      Map<String, dynamic> addressJson) async {
    try {
      final userId = AuthenticationRepository.getUserId();
      if (userId.isEmpty) throw "Unable to find user information";
      // Reference to the user's address subcollection
      CollectionReference addressesCollection =
          _db.collection("Users").doc(userId).collection('Addresses');

      // Check if the collection is empty
      QuerySnapshot snapshot = await addressesCollection.get();

      // Determine if this is the first address being added
      bool isFirstAddress = snapshot.docs.isEmpty;

      // Update the `selectedAddress` key in the received addressJson
      addressJson['selectedAddress'] = isFirstAddress ? true : false;

      // Add the new address to the user's Addresses collection
      DocumentReference docRef = await addressesCollection.add(addressJson);

      // Fetch the newly created document to get its data
      DocumentSnapshot doc = await docRef.get();

      // Cast the document's data to Map<String, dynamic>
      final data = doc.data() as Map<String, dynamic>?;

      // Check if the data is null, which could happen if the document doesn't exist or is empty
      if (data == null) {
        throw "Document does not contain any data";
      }

      // Create and return an AddressModel instance using the data
      return AddressModel.fromMap(data);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase Exception: $e");
      }
      throw "An error occurred while connecting to the database.";
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("Format Exception: $e");
      }
      throw "There was a problem with the data format.";
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Platform Exception: $e");
      }
      throw "A platform error occurred: $e";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw "Something went wrong. Please try again.\nError: $e";
    }
  }

  /// Clean the "selected" field for all addresses
  static Future<void> updateSelectedField(
      String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.getUserId();
      if (userId.isEmpty) {
        throw Exception("Unable to find user Information");
      }
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
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

  static Future<void> deleteSelectedField(String addressId) async {
    try {
      final userId = AuthenticationRepository.getUserId();
      if (userId.isEmpty) {
        throw Exception("Unable to find user Information");
      }
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .delete();
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
