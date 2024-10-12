import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:martify/Model/address_model.dart';
import 'package:martify/Model/cart%20model/cart_item_model.dart';
import 'package:martify/Model/payment_method_model.dart';

class OrderModel {
  final String userId;
  final String status;
  final String totalAmount;
  final DateTime orderDate;
  final PaymentMethodModel paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final String orderId;
  final String? taxFee;
  final String? shippingFee;
  final String? cartTotal;

  OrderModel({
    required this.orderId,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.paymentMethod,
    this.address,
    this.deliveryDate,
    this.taxFee,
    this.shippingFee,
    this.cartTotal,
  });

  /// Empty model
  factory OrderModel.empty() {
    return OrderModel(
      orderId: '',
      status: 'pending',
      items: [],
      totalAmount: '0.0',
      orderDate: DateTime.now(),
      paymentMethod: PaymentMethodModel.empty(),
      taxFee: null,
      shippingFee: null,
      cartTotal: null,
    );
  }

  /// From JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] ?? '',
      userId: json['userId'] ?? '',
      status: json['status'] ?? 'pending',
      totalAmount: json['totalAmount']?.toString() ?? '0.0',
      orderDate: (json['orderDate'] as Timestamp).toDate(),
      paymentMethod: PaymentMethodModel(
        name: json['paymentMethod']['name'] ?? 'Cash On Delivery',
        image: json['paymentMethod']['image'] ?? '',
      ),
      address: json['address'] != null
          ? AddressModel.fromMap(json['address'])
          : null,
      deliveryDate: json['deliveryDate'] != null
          ? (json['deliveryDate'] as Timestamp).toDate()
          : null,
      taxFee: json['taxFee']?.toString(),
      shippingFee: json['shippingFee']?.toString(),
      cartTotal: json['cartTotal']?.toString(),
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'status': status,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': {
        'name': paymentMethod.name,
        'image': paymentMethod.image,
      },
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'taxFee': taxFee,
      'shippingFee': shippingFee,
      'cartTotal': cartTotal,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  /// From Firestore DocumentSnapshot
  factory OrderModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return OrderModel(
      orderId: doc.id,
      userId: data['userId'] ?? '',
      status: data['status'] ?? 'pending',
      totalAmount: data['totalAmount']?.toString() ?? '0.0',
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: PaymentMethodModel(
        name: data['paymentMethod']['name'] ?? 'Cash On Delivery',
        image: data['paymentMethod']['image'] ?? '',
      ),
      address: data['address'] != null
          ? AddressModel.fromMap(data['address'])
          : null,
      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
      taxFee: data['taxFee']?.toString(),
      shippingFee: data['shippingFee']?.toString(),
      cartTotal: data['cartTotal']?.toString(),
      items: (data['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
}
// class OrderModel {
//   final String userId;
//   final String status;
//   final String totalAmount;
//   final DateTime orderDate;
//   final String paymentMethod;
//   final AddressModel? address;
//   final DateTime? deliveryDate;
//   final List<CartItemModel> items;
//   final String orderId;
//   final String? taxFee;
//   final String? shippingFee;
//   final String? cartTotal;

//   OrderModel({
//     required this.orderId,
//     this.userId = '',
//     required this.status,
//     required this.items,
//     required this.totalAmount,
//     required this.orderDate,
//     this.paymentMethod = 'Cash On Delivery',
//     this.address,
//     this.deliveryDate,
//     this.taxFee,
//     this.shippingFee,
//     this.cartTotal,
//   });

//   /// Empty model
//   factory OrderModel.empty() {
//     return OrderModel(
//       orderId: '',
//       status: 'pending',
//       items: [],
//       totalAmount: '0.0',
//       orderDate: DateTime.now(),
//       taxFee: null,
//       shippingFee: null,
//       cartTotal: null,
//     );
//   }

//   /// From JSON
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       orderId: json['orderId'] ?? '',
//       userId: json['userId'] ?? '',
//       status: json['status'] ?? 'pending',
//       totalAmount: json['totalAmount']?.toString() ?? '0.0',
//       orderDate: (json['orderDate'] as Timestamp).toDate(),
//       paymentMethod: json['paymentMethod'] ?? 'Cash On Delivery',
//       address: json['address'] != null
//           ? AddressModel.fromMap(json['address'])
//           : null,
//       deliveryDate: json['deliveryDate'] != null
//           ? (json['deliveryDate'] as Timestamp).toDate()
//           : null,
//       taxFee: json['taxFee']?.toString(),
//       shippingFee: json['shippingFee']?.toString(),
//       cartTotal: json['cartTotal']?.toString(),
//       items: (json['items'] as List)
//           .map((item) => CartItemModel.fromJson(item))
//           .toList(),
//     );
//   }

//   /// To JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'orderId': orderId,
//       'userId': userId,
//       'status': status,
//       'totalAmount': totalAmount,
//       'orderDate': orderDate,
//       'paymentMethod': paymentMethod,
//       'address': address?.toJson(),
//       'deliveryDate': deliveryDate,
//       'taxFee': taxFee,
//       'shippingFee': shippingFee,
//       'cartTotal': cartTotal,
//       'items': items.map((item) => item.toJson()).toList(),
//     };
//   }

//   /// From Firestore DocumentSnapshot
//   factory OrderModel.fromDocumentSnapshot(
//       DocumentSnapshot<Map<String, dynamic>> doc) {
//     final data = doc.data()!;
//     return OrderModel(
//       orderId: doc.id,
//       userId: data['userId'] ?? '',
//       status: data['status'] ?? 'pending',
//       totalAmount: data['totalAmount']?.toString() ?? '0.0',
//       orderDate: (data['orderDate'] as Timestamp).toDate(),
//       paymentMethod: data['paymentMethod'] ?? 'Cash On Delivery',
//       address: data['address'] != null
//           ? AddressModel.fromMap(data['address'])
//           : null,
//       deliveryDate: data['deliveryDate'] != null
//           ? (data['deliveryDate'] as Timestamp).toDate()
//           : null,
//       taxFee: data['taxFee']?.toString(),
//       shippingFee: data['shippingFee']?.toString(),
//       cartTotal: data['cartTotal']?.toString(),
//       items: (data['items'] as List)
//           .map((item) => CartItemModel.fromJson(item))
//           .toList(),
//     );
//   }
// }