// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/popups/full_screen_loader.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

class UploadDataInFirebase {
  static Future<void> uploadcategories(BuildContext context) async {
    try {
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);
      // Create the "Categories" collection
      final categoriesCollection =
          FirebaseFirestore.instance.collection('Categories');

      // Create a list of image file paths
      final imagePaths = [
        'assets/icons/categories/bowling.png',
        'assets/icons/categories/cosmetics.png',
        'assets/icons/categories/dining-chair.png',
        'assets/icons/categories/dog-heart.png',
        'assets/icons/categories/school-uniform.png',
        'assets/icons/categories/shoes.png',
        'assets/icons/categories/smartphone.png',
        'assets/icons/categories/sparkling-diamond.png',
        'assets/icons/categories/tailors-dummy.png',
        'assets/icons/categories/wooden-toy-car.png',
      ];

      // Iterate over image paths and upload data to Firebase
      for (int i = 0; i < imagePaths.length; i++) {
        final imagePath = imagePaths[i];
        final imageName = 'category${i + 1}.jpg'; // Use a unique filename

        // Load asset as bytes
        final byteData = await rootBundle.load(imagePath);
        final imageBytes = byteData.buffer.asUint8List();

        // Upload image to Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref().child('categories/$imageName');
        final uploadTask = storageRef.putData(imageBytes);
        final taskSnapshot = await uploadTask.whenComplete(() => null);
        final imageDownloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Create a document in the "Categories" collection
        final documentRef = categoriesCollection.doc('${i + 1}');
        await documentRef.set({
          'image': imageDownloadUrl,
          'isFeatured': true,
          'name': 'Category ${i + 1}', // Replace with your desired name
          'parentId': null,
        });
      }
      FullScreenLoader.hide(context);
      SnackbarService.showSucccess(context: context, message: "Uploaded");
    } catch (e) {
      FullScreenLoader.hide(context);
      if (kDebugMode) {
        print("error while fetchting categoriesError:$e");
      }
      SnackbarService.showError(context: context, message: "Error : $e");
    }
  }

  static Future<void> uploadBanners(BuildContext context) async {
    try {
      // Show the full-screen loader
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);

      // Create the "Banners" collection
      final bannersCollection =
          FirebaseFirestore.instance.collection('Banners');

      // List of image paths based on your assets directory
      final imagePaths = [
        'assets/images/banners/banner_1.jpg',
        'assets/images/banners/banner_2.jpg',
        'assets/images/banners/banner_3.jpg',
        'assets/images/banners/banner_4.jpg',
        'assets/images/banners/banner_5.jpg',
        'assets/images/banners/banner_6.jpg',
        'assets/images/banners/banner_7.jpg',
        'assets/images/banners/banner_8.jpg',
      ];

      // Iterate over image paths and upload data to Firebase
      for (int i = 0; i < imagePaths.length; i++) {
        final imagePath = imagePaths[i];
        final imageName =
            'banner_${i + 1}.jpg'; // Naming convention for the image

        // Load the asset image as bytes
        final byteData = await rootBundle.load(imagePath);
        final imageBytes = byteData.buffer.asUint8List();

        // Upload image to Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref().child('banners/$imageName');
        final uploadTask = storageRef.putData(imageBytes);
        final taskSnapshot = await uploadTask.whenComplete(() => null);
        final imageDownloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Create a document in the "Banners" collection
        await bannersCollection.add({
          'imageUrl': imageDownloadUrl,
          'active': false, // Set the 'active' field to false
          'targetScreen':
              '/search', // Set the 'targetScreen' field to "/search"
        });
      }

      // Hide the full-screen loader after uploading
      FullScreenLoader.hide(context);
      SnackbarService.showSucccess(
          context: context, message: "Banners uploaded successfully!");
    } catch (e) {
      // Hide the loader in case of an error
      FullScreenLoader.hide(context);
      if (kDebugMode) {
        print("Error while uploading banners: $e");
      }
      // Show error snackbar
      SnackbarService.showError(context: context, message: "Error: $e");
    }
  }

  static Future<void> addIsFeaturedFieldToAllProducts(
      BuildContext context) async {
    try {
      // Get a reference to the Firestore collection
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);
      final CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('products');

      // Fetch all products from the collection
      QuerySnapshot querySnapshot = await productsCollection.get();

      // Loop through each document and update it with the 'isFeatured' field
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await productsCollection.doc(document.id).update({
          'isFeatured': true, // Add the new field with value true
        });
      }
      FullScreenLoader.hide(context);
      SnackbarService.showSucccess(context: context, message: "added");
    } catch (e) {
      FullScreenLoader.hide(context);
      SnackbarService.showError(context: context, message: "$e");
    }
  }

  static Future<void> addBrandsToFirestore(
      List<Map<String, dynamic>> brands, BuildContext context) async {
    final CollectionReference brandsCollection =
        FirebaseFirestore.instance.collection('Brands');

    for (var brand in brands) {
      try {
        FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);
        // Using the 'id' field to set the document ID
        await brandsCollection.doc(brand['id'].toString()).set({
          'name': brand['name'],
          'image': brand['image'],
          'isFeatured': brand['isFeatured'],
          'productCount': brand['productCount'],
        });
        FullScreenLoader.hide(context);
        print('Brand ${brand['name']} added successfully.');
      } catch (e) {
        FullScreenLoader.hide(context);
        print('Failed to add brand ${brand['name']}: $e');
      }
    }
  }

  static Future<void> updateProductsBrandField(BuildContext context) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the products collection
    final CollectionReference<Map<String, dynamic>> productsCollection =
        firestore.collection('products').withConverter<Map<String, dynamic>>(
              fromFirestore: (snapshot, _) => snapshot.data()!,
              toFirestore: (data, _) => data,
            );

    try {
      FullScreenLoader.show(context, lottieAsset: MImages.docerAnimation);
      // Get all documents in the products collection
      final QuerySnapshot<Map<String, dynamic>> productsSnapshot =
          await productsCollection.get();

      for (var doc in productsSnapshot.docs) {
        // Get the current data of the product
        final data = doc.data();

        // Check if the brand field is a map with an 'id' key
        if (data['brand'] is Map<String, dynamic> &&
            data['brand']['id'] != null) {
          // Extract the brand id
          int brandId = data['brand']['id'];

          // Update the product's brand field to just the int brandId
          await doc.reference.update({
            'brand': brandId, // Set the brand field to the extracted int
          });

          print("Updated product ${doc.id} with brand id: $brandId");
        }
      }
      FullScreenLoader.hide(context);
      print('All product brand fields updated successfully.');
    } catch (e) {
      FullScreenLoader.hide(context);
      print('Error updating brand fields: $e');
    }
  }

  static Future<void> migrateProductsToProductCategory() async {
    // Initialize Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Step 1: Get all products from the "products" collection
      QuerySnapshot productsSnapshot =
          await firestore.collection('products').get();

      // Step 2: Prepare a batch write to perform multiple operations
      WriteBatch batch = firestore.batch();

      int docCounter = 1;

      // Step 3: Loop through each product document
      for (QueryDocumentSnapshot productDoc in productsSnapshot.docs) {
        // Get product ID and CategoryId
        String productId = productDoc.id.toString();
        String? categoryId = productDoc
            .get('categoryId')
            .toString(); // Assuming the field is named "CategoryId"

        // Step 4: Create a new document in "ProductCategory" with incrementing doc IDs
        DocumentReference newDocRef =
            firestore.collection('ProductCategory').doc(docCounter.toString());

        // Set the fields in the new document
        batch.set(newDocRef, {
          'productId': productId,
          'categoryId': categoryId,
        });

        // Increment document counter
        docCounter++;
      }

      // Step 5: Commit the batch write
      await batch.commit();
      print("Migration completed successfully!");
    } catch (e) {
      print("Error migrating products: $e");
    }
  }

  static Future<void> updateFieldInAllDocs() async {
    // Reference to the Firestore collection
    CollectionReference productCategoryCollection =
        FirebaseFirestore.instance.collection('ProductCategory');

    try {
      // Get all documents in the collection
      QuerySnapshot querySnapshot = await productCategoryCollection.get();

      // Loop through each document
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check if the document contains the old field
        if (data.containsKey('brandId')) {
          // Create a new field 'productId' with the value from 'brandId'
          data['productId'] = data['brandId'];

          // Remove the old field 'brandId'
          data.remove('brandId');

          // Update the document with the new data
          await productCategoryCollection.doc(doc.id).set(data);
        }
      }

      print('Field name updated successfully in all documents.');
    } catch (e) {
      print('Error updating field name: $e');
    }
  }
}
