part of 'wishlist_bloc.dart';

class WishlistState extends Equatable {
  final Map<String, bool> favorites;
  final List<ProductModel> allProducts;

  const WishlistState(
      {this.favorites = const <String, bool>{},
      this.allProducts = const <ProductModel>[]});

  WishlistState copyWith(
      {Map<String, bool>? favorites, List<ProductModel>? allProducts}) {
    return WishlistState(
        favorites: favorites ?? this.favorites,
        allProducts: allProducts ?? this.allProducts);
  }

  @override
  List<Object> get props => [favorites, allProducts];
}
