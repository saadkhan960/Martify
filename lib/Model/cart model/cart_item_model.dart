class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String? brandName;
  String size;
  String color;

  /// Constructor with default values for size and color
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.size = '',
    this.color = '',
    this.image = '',
    this.price = 0.0,
    this.title = '',
    this.brandName,
  });

  /// Empty Model method
  factory CartItemModel.empty() {
    return CartItemModel(
      productId: '',
      quantity: 0,
      size: '',
      color: '',
      image: '',
      price: 0.0,
      title: '',
      brandName: '',
    );
  }

  /// fromJson method for JSON deserialization
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      image: json['image'],
      quantity: json['quantity'] ?? 0,
      brandName: json['brandName'],
      size: json['size'] ?? '',
      color: json['color'] ?? '',
    );
  }

  /// toJson method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'brandName': brandName,
      'size': size,
      'color': color,
    };
  }

  /// copyWith method
  CartItemModel copyWith({
    String? productId,
    String? title,
    double? price,
    String? image,
    int? quantity,
    String? brandName,
    String? size,
    String? color,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      brandName: brandName ?? this.brandName,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}
