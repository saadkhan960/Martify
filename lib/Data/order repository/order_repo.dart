import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:martify/Data/repository.Auth/auth_repository.dart';
import 'package:martify/Model/Order%20Model/order_model.dart';

class OrderRepo {
  static final _db = FirebaseFirestore.instance;

//Add Order
  static Future<void> addOrder(
      {required OrderModel orderModel,
      required String userId,
      required String customDocId}) async {
    try {
      await _db
          .collection("Users")
          .doc(userId)
          .collection('Orders')
          .doc(customDocId) // Provide your custom document ID here
          .set(orderModel.toJson()); // Set data to the document
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
      throw "Something Went Wrong While Create Order in repository. Please Try Again \n Error: $e";
    }
  }

//Fetch Orders
  static Future<List<OrderModel>> fetchOrders() async {
    try {
      final String userId = AuthenticationRepository.getUserId();
      if (userId.isEmpty) throw "Unable to find User. Session Expired!";
      final result =
          await _db.collection("Users").doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnap) => OrderModel.fromDocumentSnapshot(documentSnap))
          .toList();
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
      throw "Something Went Wrong While Getting Order in repository. Please Try Again \n Error: $e";
    }
  }
}
