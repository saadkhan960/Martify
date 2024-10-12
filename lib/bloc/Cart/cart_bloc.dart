import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Model/cart%20model/cart_item_model.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/local_storage/storage_utility.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final MLocalStorage storage = MLocalStorage.instance();
  CartBloc() : super(const CartState()) {
    on<InitCart>(_initCart);
    on<AddOrUpdateCartItem>(_addOrUpdateCartItem);
    on<RemoveCartItem>(_removeCartItem);
    on<ClearCart>(_clearCart);
    on<IsProductInCart>(_isProductInCart);
    on<AddQuantityInCart>(_addQuantityInCart);
    on<RemoveCartlistForLogout>(_removeCartlistForLogout);
  }
// -------------------------Initialize Cart - Read from Storage----------------------------------------------
  void _initCart(InitCart event, Emitter<CartState> emit) {
    // Read data from storage
    final dynamic json = storage.readData('cartItems');
    print("allcarts: $json");

    if (json != null) {
      // Check if the json data is of List type
      if (json is List) {
        // Create a map to hold cart items with unique keys
        final Map<String, CartItemModel> cartItems = {
          for (var item in json)
            // Create a unique key using productId, size, and color
            MHelperFunctions.generateUniqueKey(
              CartItemModel.fromJson(item).productId,
              CartItemModel.fromJson(item).size,
              CartItemModel.fromJson(item).color,
            ): CartItemModel.fromJson(item)
        };

        final allCartItems = cartItems.values.toList();
        print("cart items-------: $cartItems");

        // Emit the updated state with cart items
        emit(state.copyWith(cartItems: cartItems, allCartItems: allCartItems));
      } else {
        print("Expected a List but got: ${json.runtimeType}");
      }
    }
  }

  // ---------------------Add or Update Cart Item------------------------------------------
  void _addOrUpdateCartItem(
      AddOrUpdateCartItem event, Emitter<CartState> emit) async {
    final updatedCartItems = Map<String, CartItemModel>.from(state.cartItems);

    // Create a unique key by combining productId, size, and color
    final uniqueKey = MHelperFunctions.generateUniqueKey(
        event.productId, event.size, event.color);

    // Check if a product with the same productId, size, and color already exists
    if (updatedCartItems.containsKey(uniqueKey)) {
      // If product with the same attributes exists, update the quantity
      // final existingItem = updatedCartItems[uniqueKey]!;
      // final updatedItem = existingItem.copyWith(
      //   quantity: existingItem.quantity + event.quantity,
      // );
      // updatedCartItems[uniqueKey] = updatedItem;

      // Show success message for quantity update
      SnackbarService.showSimpleMessage(
          context: event.context, message: 'Product Already In Cart');
    } else {
      // Add a new product with the given size and color
      final newItem = CartItemModel(
        productId: event.productId,
        title: event.title,
        price: event.price,
        quantity: event.quantity,
        image: event.image,
        brandName: event.brandName,
        size: event.size,
        color: event.color,
      );
      updatedCartItems[uniqueKey] = newItem;

      // Show success message for new product added
      SnackbarService.showSimpleMessage(
          context: event.context, message: 'Product added to cart');
    }

    // Save updated cart to storage
    await storage.saveData('cartItems',
        updatedCartItems.values.map((item) => item.toJson()).toList());

    // Emit the updated state with the modified cart items
    final allCartItems = updatedCartItems.values.toList();
    emit(state.copyWith(
        cartItems: updatedCartItems, allCartItems: allCartItems));
  }

  // ---------------------Remove Cart Item-----------------------------------------

  void _removeCartItem(RemoveCartItem event, Emitter<CartState> emit) async {
    try {
      final updatedCartItems = Map<String, CartItemModel>.from(state.cartItems);

      // Generate the unique key using productId, size, and color
      final uniqueKey = MHelperFunctions.generateUniqueKey(
          event.productId, event.size, event.color);

      // Remove the item based on the unique key
      updatedCartItems.remove(uniqueKey);

      // Save updated cart to storage
      await storage.saveData('cartItems',
          updatedCartItems.values.map((item) => item.toJson()).toList());

      // Emit the updated state with the modified cart items
      final allCartItems = updatedCartItems.values.toList();
      emit(state.copyWith(
          cartItems: updatedCartItems, allCartItems: allCartItems));
    } catch (e) {
      if (kDebugMode) {
        print("error while delting cart item $e");
      }
    }
  }

  // ---------------------Clear Cart---------------------------------------------------
  void _clearCart(ClearCart event, Emitter<CartState> emit) async {
    await storage.removeData('cartItems');
    emit(const CartState(cartItems: {}, allCartItems: []));
  }

//--------------------- is product in cart or not------------------------------------------
  void _isProductInCart(IsProductInCart event, Emitter<CartState> emit) {
    final cartItems = state.cartItems;

    // Create the unique key using productId, size, and color
    final uniqueKey = MHelperFunctions.generateUniqueKey(
        event.productId, event.size, event.color);

    // Check if the unique key exists in the cart items
    final isInCart = cartItems.containsKey(uniqueKey);

    // You can emit the state or handle it as per your requirements
    emit(state.copyWith(isProductInCart: isInCart));
  }

  //--------------------- increase or decrease cart item, quantity------------------------------------------
  void _addQuantityInCart(
      AddQuantityInCart event, Emitter<CartState> emit) async {
    // Generate the unique key for the cart item
    final uniqueKey = MHelperFunctions.generateUniqueKey(
      event.productId,
      event.size,
      event.color,
    );

    // Check if the item is in the cart
    if (state.cartItems.containsKey(uniqueKey)) {
      // Get the current cart item
      final CartItemModel currentItem = state.cartItems[uniqueKey]!;
      late CartItemModel updatedItem;
      // Create a new CartItemModel with updated quantity
      if (event.addfunction) {
        updatedItem = currentItem.copyWith(
          quantity: currentItem.quantity + 1, // Increment quantity
        );
      } else {
        if (currentItem.quantity > 1) {
          updatedItem = currentItem.copyWith(
            quantity: currentItem.quantity - 1, // Decrement quantity
          );
        } else {
          return;
        }
      }

      // Update the cart with the new item
      final updatedCartItems = Map<String, CartItemModel>.from(state.cartItems);
      updatedCartItems[uniqueKey] = updatedItem;

      // Convert the updated cartItems map to a list for allCartItems
      final allCartItems = updatedCartItems.values.toList();

      // Save updated cart to local storage
      await storage.saveData('cartItems',
          updatedCartItems.values.map((item) => item.toJson()).toList());

      // Emit the new state with updated cartItems and allCartItems
      emit(state.copyWith(
        cartItems: updatedCartItems,
        allCartItems: allCartItems,
      ));
    }
  }

  // ---remove before logout---
  void _removeCartlistForLogout(
      RemoveCartlistForLogout event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartItems: {}, allCartItems: []));
  }
}
