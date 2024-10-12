import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:martify/Model/banner_model.dart';

class BannerRepository {
  static final _db = FirebaseFirestore.instance;

//Gett All Categories
  static Future<List<BannerModel>> fetchBanners() async {
    try {
      //get those banners only who's "active" field value is true
      final result = await _db
          .collection("Banners")
          .where('active', isEqualTo: true)
          .get();
      final list = result.docs
          .map((document) => BannerModel.fromSnapshot(document))
          .toList();
      return list;
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
