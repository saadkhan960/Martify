import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';

class ProductRepository {
  static final _db = FirebaseFirestore.instance;

//Get limit featured products From Firebase databse
  static Future<List<ProductModel>> getFeaturedProducts(int limit) async {
    try {
      final snapshot = await _db
          .collection("products")
          .where("isFeatured", isEqualTo: true)
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

  //Get all featured brands From Firebase databse
  static Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      final snapshot = await _db
          .collection("Brands")
          .where("isFeatured", isEqualTo: true)
          .get();
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
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

  //Get all featured products From Firebase databse
  static Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
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

  //Get All featured products From Firebase databse
  static Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection("products")
          .where("isFeatured", isEqualTo: true)
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
  static Future<List<ProductModel>> getCategoryRealtedProucts(
      {required int categoryId, required int limit}) async {
    try {
      final snapshot = await _db
          .collection("products")
          .where("categoryId", isEqualTo: categoryId)
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

  //No Limit function
  static Future<List<ProductModel>> getAllCategoryRealtedProucts(
      {required int categoryId}) async {
    try {
      final snapshot = await _db
          .collection("products")
          .where("categoryId", isEqualTo: categoryId)
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

  //product fetch for whishlist screen fetch those product who are not in list
  //No Limit function
  static Future<List<ProductModel>> fetchProductsFromFirebase(
      {required List<String> productIds}) async {
    try {
      List<ProductModel> fetchedProducts = [];

      // Fetch each product document by ID
      for (String productId in productIds) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .doc(productId) // Fetch by document ID
            .get();

        // Check if the document exists
        if (documentSnapshot.exists) {
          // Map the document to your ProductModel
          final product = ProductModel.fromSnapshot(documentSnapshot);
          fetchedProducts.add(product);
        } else {
          print("Document with ID: $productId does not exist.");
        }
      }

      print("Fetched Products: $fetchedProducts");
      return fetchedProducts;
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
