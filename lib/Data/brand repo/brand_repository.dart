import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';

class BrandRepository {
  static final _db = FirebaseFirestore.instance;

  static Future<List<ProductModel>> getBrandRelatedProducts(
      {required BuildContext context, required int brandId}) async {
    try {
      final snapshot = await _db
          .collection("products")
          .where("brand", isEqualTo: brandId)
          .get();
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
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

//Limit set function
  static Future<List<ProductModel>> getBrandRelatedProductsWithLimit(
      {required BuildContext context,
      required int brandId,
      required int limit}) async {
    try {
      final snapshot = await _db
          .collection("products")
          .where("brand", isEqualTo: brandId)
          .limit(limit)
          .get();

      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
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

  // Get Brand For Categories
  static Future<List<BrandModel>> getBrandForCategories(
      {required String categoryId}) async {
    try {
      //Query to get all doc where categoryId matches the provided category id
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      //Extract brandsId from the Documents
      List<dynamic> brandIds =
          brandCategoryQuery.docs.map((doc) => doc['brandId']).toList();

      //Query to get all doc where the brandid is in the list of brandids

      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return brands;
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
