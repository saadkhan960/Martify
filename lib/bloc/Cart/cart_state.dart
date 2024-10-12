part of 'cart_bloc.dart';

class CartState extends Equatable {
  final Map<String, CartItemModel> cartItems; // Using unique keys
  final List<CartItemModel> allCartItems;
  final bool isProductInCart;

  const CartState({
    this.cartItems = const {},
    this.allCartItems = const [],
    this.isProductInCart = false,
  });

  CartState copyWith({
    Map<String, CartItemModel>? cartItems,
    List<CartItemModel>? allCartItems,
    bool? isProductInCart,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      allCartItems: allCartItems ?? this.allCartItems,
      isProductInCart: isProductInCart ?? this.isProductInCart,
    );
  }

  @override
  List<Object> get props => [cartItems, allCartItems, isProductInCart];
}
