import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/brand%20repo/brand_repository.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

class BrandController {
  static Future<List<ProductModel>> getBrandRelatedProducts(
      {required BuildContext context, required int brandId}) async {
    try {
      final products = await BrandRepository.getBrandRelatedProducts(
          context: context, brandId: brandId);
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
  static Future<List<ProductModel>> getBrandRelatedProductsWithLimit(
      {required BuildContext context,
      required int brandId,
      required int limit}) async {
    try {
      final products = await BrandRepository.getBrandRelatedProductsWithLimit(
          context: context, brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      if (kDebugMode) {
        print("Error while fetching All products, Error: $e");
      }
      SnackbarService.showError(context: context, message: e.toString());
      return [];
    }
  }

  // Get Brand For Categories
  static Future<List<BrandModel>> getBrandForCategories(
      {required BuildContext context, required String categoryId}) async {
    try {
      final brands =
          await BrandRepository.getBrandForCategories(categoryId: categoryId);
      return brands;
    } catch (e) {
      if (kDebugMode) {
        print("Error while getting brands, Error: $e");
      }
      SnackbarService.showError(context: context, message: e.toString());
      return [];
    }
  }
}
