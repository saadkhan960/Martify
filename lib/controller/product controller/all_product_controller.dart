import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/product%20Repo/product_repository.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

class AllProductController {
  static Future<List<ProductModel>> fetchProductsByQuery(
      Query? query, BuildContext context) async {
    try {
      if (query == null) return [];
      final products = await ProductRepository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      SnackbarService.showError(context: context, message: e.toString());
      return [];
    }
  }

  static Future<List<ProductModel>> fetchAllProducts(
      BuildContext context) async {
    try {
      //Fetch all products from FireStore
      final products = await ProductRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      if (kDebugMode) {
        print("Error while fetching All products, Error: $e");
      }
      SnackbarService.showError(context: context, message: e.toString());
      return [];
    }
  }

  //limit set function
  static Future<List<ProductModel>> getCategoryRealtedProucts(
      {required BuildContext context,
      required int categoryId,
      required int limit}) async {
    try {
      final products = await ProductRepository.getCategoryRealtedProucts(
          categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      if (kDebugMode) {
        print("Error while fetching All products, Error: $e");
      }
      SnackbarService.showError(context: context, message: e.toString());
      return [];
    }
  }

  //no limit
  static Future<List<ProductModel>> getAllCategoryRealtedProucts(
      {required BuildContext context, required int categoryId}) async {
    try {
      final products = await ProductRepository.getAllCategoryRealtedProucts(
          categoryId: categoryId);
      return products;
    } catch (e) {
      if (kDebugMode) {
        print("Error while fetching All products, Error: $e");
      }
      SnackbarService.showError(context: context, message: e.toString());
      return [];
    }
  }
}
