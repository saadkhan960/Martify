import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Data/product%20Repo/product_repository.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/local_storage/storage_utility.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistState()) {
    on<InitFavorites>(_initFavorites);
    // on<IsFavourite>(_isFavourite);
    on<ToggleFavProduct>(_toggleFavProduct);
    on<SaveFavToStorage>(_saveFavToStorage);
    on<FetchFavProducts>(_fetchFavProducts);
    on<RemoveWhishlistForLogout>(_removeWhishlistForLogout);
  }
//method to initialize fav by reading from storage when app start
  void _initFavorites(InitFavorites event, Emitter<WishlistState> emit) {
    final json = MLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storageFav = jsonDecode(json) as Map<String, dynamic>;
      emit(state.copyWith(
          favorites:
              storageFav.map((key, value) => MapEntry(key, value as bool))));
    }
  }

  // check product is on fav or not
  // bool _isFavourite(IsFavourite event, Emitter<WishlistState> emit) {
  //   return state.favorites[event.productId] ?? false;
  // }
  void _toggleFavProduct(ToggleFavProduct event, Emitter<WishlistState> emit) {
    try {
      final productId = event.productId;
      final context = event.context;
      final isFav = state.favorites[productId] ?? false;

      final updatedFavorites = Map<String, bool>.from(
          state.favorites); // Create a new copy of the favorites map
      if (!isFav) {
        updatedFavorites[productId] = true;
        SnackbarService.showSimpleMessage(
            context: context,
            message: 'Product has been added to the Wishlist.');
      } else {
        updatedFavorites.remove(productId);
        SnackbarService.showSimpleMessage(
            context: context,
            message: 'Product has been removed from the Wishlist.');
      }

      emit(state.copyWith(
          favorites:
              updatedFavorites)); // Emit the new state with updated favorites
      add(SaveFavToStorage());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _saveFavToStorage(SaveFavToStorage event, Emitter<WishlistState> emit) {
    final encodedFav = json.encode(state.favorites);
    MLocalStorage.instance().saveData('favorites', encodedFav);
  }

  void _removeWhishlistForLogout(
      RemoveWhishlistForLogout event, Emitter<WishlistState> emit) {
    emit(state.copyWith(favorites: {}, allProducts: []));
  }

  void _fetchFavProducts(
      FetchFavProducts event, Emitter<WishlistState> emit) async {
    final favoriteProductIds = state.favorites.keys.toList();
    final currentProducts = state.allProducts;

    // Jo products already allProducts mein hain, unko exclude karenge
    final missingProductIds = favoriteProductIds
        .where((id) => !currentProducts.any((product) => product.id == id))
        .toList();

    // Firebase se sirf un products ko fetch karenge jo missing hain
    List<ProductModel> missingProducts = [];
    if (missingProductIds.isNotEmpty) {
      missingProducts = await ProductRepository.fetchProductsFromFirebase(
          productIds: missingProductIds);
    }

    // Already available products + newly fetched products ko combine karenge
    final updatedProducts = [...currentProducts, ...missingProducts];

    // Nayi state ko emit karenge updated products ke saath
    emit(state.copyWith(allProducts: updatedProducts));
  }
}
