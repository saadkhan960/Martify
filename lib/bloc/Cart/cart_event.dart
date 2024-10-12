part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// Initialize the cart by reading from storage
class InitCart extends CartEvent {}

// Check if a product with specific attributes (productId, size, color) is in the cart
class IsProductInCart extends CartEvent {
  final String productId;
  final String size;
  final String color;

  const IsProductInCart({
    required this.productId,
    required this.size,
    required this.color,
  });

  @override
  List<Object> get props => [productId, size, color];
}

// Add or update a product in the cart
class AddOrUpdateCartItem extends CartEvent {
  final BuildContext context;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String? image;
  final String? brandName;
  final String size;
  final String color;

  const AddOrUpdateCartItem({
    required this.context,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    this.image,
    this.brandName,
    required this.size,
    required this.color,
  });

  @override
  List<Object> get props => [
        context,
        productId,
        title,
        price,
        quantity,
        image ?? '',
        brandName ?? '',
        size,
        color,
      ];
}

// Remove a product from the cart using productId, size, and color
class RemoveCartItem extends CartEvent {
  final String productId;
  final String size;
  final String color;

  const RemoveCartItem({
    required this.productId,
    required this.size,
    required this.color,
  });

  @override
  List<Object> get props => [productId, size, color];
}

// Save the cart to storage
class SaveCartToStorage extends CartEvent {}

// Fetch all cart products from storage
class FetchCartProducts extends CartEvent {
  final BuildContext context;
  const FetchCartProducts({required this.context});

  @override
  List<Object> get props => [context];
}

// Clear the cart
class ClearCart extends CartEvent {}

class RemoveCartlistForLogout extends CartEvent {}

class AddQuantityInCart extends CartEvent {
  final String productId;
  final String size;
  final String color;
  final bool addfunction;

  const AddQuantityInCart(
      {required this.productId,
      required this.size,
      required this.color,
      required this.addfunction});

  @override
  List<Object> get props => [productId, size, color, addfunction];
}
