part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

//method to initialize fav by reading from storage
class InitFavorites extends WishlistEvent {}

// check product is on fav or not
class IsFavourite extends WishlistEvent {
  final String productId;
  const IsFavourite({required this.productId});
  @override
  List<Object> get props => [productId];
}

class ToggleFavProduct extends WishlistEvent {
  final BuildContext context;
  final String productId;
  const ToggleFavProduct({required this.context, required this.productId});
  @override
  List<Object> get props => [context, productId];
}

class SaveFavToStorage extends WishlistEvent {}

class FetchFavProducts extends WishlistEvent {
  final BuildContext context;
  const FetchFavProducts({required this.context});
  @override
  List<Object> get props => [context];
}

class RemoveWhishlistForLogout extends WishlistEvent {}
