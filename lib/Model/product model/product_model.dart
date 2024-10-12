import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String title;
  double price;
  double? salePrice;
  int stock;
  String sku;
  String description;
  List<String> images;
  List<String>? colors;
  List<String>? sizes;
  int brand; // Changed from Brand to int
  int categoryId;
  bool isFeatured;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    this.salePrice,
    required this.stock,
    required this.sku,
    required this.description,
    required this.images,
    this.colors,
    this.sizes,
    required this.brand, // Now an int
    required this.categoryId,
    required this.isFeatured,
  });

  // Factory method to create ProductModel from Firestore snapshot
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductModel(
        id: document.id,
        title: data['title'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        salePrice: data['sale_price'] != ""
            ? (data['sale_price'] as num?)?.toDouble()
            : null,
        stock: data['stock'] ?? 0,
        sku: data['sku'] ?? '',
        description: data['description'] ?? '',
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        colors:
            data['colors'] != null ? List<String>.from(data['colors']) : null,
        sizes: data['sizes'] != null ? List<String>.from(data['sizes']) : null,
        brand: data['brand'] ?? 0, // Now fetching as an int
        categoryId: data['categoryId'] ?? 0,
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      return ProductModel.empty();
    }
  }

// Map json-oriented document snapshot from Firebase to model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>?;

    if (data != null) {
      return ProductModel(
        id: document.id,
        title: data['title'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        salePrice: (data['sale_price'] != null && data['sale_price'] != "")
            ? (data['sale_price'] as num?)?.toDouble()
            : null,
        stock: data['stock'] ?? 0,
        sku: data['sku'] ?? '',
        description: data['description'] ?? '',
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        colors:
            data['colors'] != null ? List<String>.from(data['colors']) : null,
        sizes: data['sizes'] != null ? List<String>.from(data['sizes']) : null,
        brand: data['brand'] ?? 0, // Fetching as int
        categoryId: data['categoryId'] ?? 0,
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      return ProductModel.empty();
    }
  }

  // Method to get the formatted price
  String getFormattedPrice() {
    final displayPrice = salePrice ?? price;
    return displayPrice % 1 == 0
        ? displayPrice.toInt().toString()
        : displayPrice.toStringAsFixed(2);
  }

  // Method to convert ProductModel to JSON format for Firestore
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'sale_price': salePrice ?? "",
      'stock': stock,
      'sku': sku,
      'description': description,
      'images': images,
      'colors': colors ?? [],
      'sizes': sizes ?? [],
      'brand': brand, // Now stored as an int
      'categoryId': categoryId,
      'isFeatured': isFeatured,
    };
  }

  // Empty ProductModel instance
  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        price: 0.0,
        salePrice: null,
        stock: 0,
        sku: '',
        description: '',
        images: ['', '', ''], // Empty list of 3 images
        colors: null,
        sizes: null,
        brand: 0, // Default brand value as 0
        categoryId: 0,
        isFeatured: false, // Default value for 'isFeatured'
      );
}
