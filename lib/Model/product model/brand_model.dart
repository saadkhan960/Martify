import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String image;
  bool isFeatured;
  String name;
  int productCount;

  BrandModel({
    required this.id,
    required this.image,
    required this.isFeatured,
    required this.name,
    required this.productCount,
  });

  // Empty instance of Brand
  static BrandModel empty() => BrandModel(
        id: '',
        image: '',
        isFeatured: false,
        name: '',
        productCount: 0,
      );

  // Factory method to create an instance of Brand from DocumentSnapshot
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return BrandModel(
        id: document.id,
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        name: data['name'] ?? '',
        productCount: data['productCount'] ?? 0,
      );
    } else {
      return BrandModel.empty(); // Return empty Brand if no data found
    }
  }

  // Method to convert Brand to a JSON-like map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'isFeatured': isFeatured,
      'name': name,
      'productCount': productCount,
    };
  }
}



// class Brand {
//   int id;
//   String image;
//   bool isFeatured;
//   String name;
//   int productCount;

//   Brand({
//     required this.id,
//     required this.image,
//     required this.isFeatured,
//     required this.name,
//     required this.productCount,
//   });

//   // Empty instance of Brand
//   static Brand empty() => Brand(
//         id: 0, // Defaulting to 0 since id is an integer
//         image: '', // Empty image string
//         isFeatured: false, // Set to false as default
//         name: '', // Empty name string
//         productCount: 0, // Defaulting to 0 product count
//       );

//   factory Brand.fromFirestore(Map<String, dynamic> json) {
//     return Brand(
//       id: json['id'],
//       image: json['image'],
//       isFeatured: json['isFeatured'],
//       name: json['name'],
//       productCount: json['productCount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'image': image,
//       'isFeatured': isFeatured,
//       'name': name,
//       'productCount': productCount,
//     };
//   }
// }

