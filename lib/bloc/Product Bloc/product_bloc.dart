import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/product%20Repo/product_repository.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<FetchProducts>(_fetchProducts);
    // on<FetchAllProducts>(_fetchAllProducts);
    on<SortAllProducts>(_sortAllProducts);
    on<AssignSortAllProducts>(_assignSortAllProducts);
    on<PageChanged>(_pageChanged);
    on<ColorSelected>(_colorSelected);
    on<SizeSelected>(_sizeSelected);
    on<QuantityChanged>(_quantityChanged);
    on<AllEmptySelction>(_allEmptySelction);
    on<InitializeVariations>(_initializeVariations);
  }
//Limit--------------------------
  void _fetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    if (state.featuredProducts.isNotEmpty) {
      // If categories are already fetched, don't fetch again
      return;
    }
    try {
      //Start Loading
      emit(state.copyWith(isLoading: true));

      //Fetch brands from FireStore
      final brands = await ProductRepository.getFeaturedBrands();

      //Update the products List
      emit(state.copyWith(featuredBrands: brands));

      //Fetch products from FireStore
      final categories = await ProductRepository.getFeaturedProducts(6);

      //Update the products List
      emit(state.copyWith(featuredProducts: categories));

      //Stop Loading
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      if (kDebugMode) {
        print("Error while fetching products, Error: $e");
      }
      SnackbarService.showError(context: event.context, message: e.toString());
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

//All----------------------------------------
  // Future<List<ProductModel>> _fetchAllProducts(
  //     FetchAllProducts event, Emitter<ProductState> emit) async {
  //   try {
  //     //Fetch all products from FireStore
  //     final products = await ProductRepository.getAllFeaturedProducts();
  //     return products;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error while fetching All products, Error: $e");
  //     }
  //     SnackbarService.showError(context: event.context, message: e.toString());
  //     return [];
  //   }
  // }
  // -------Sorted Products --------
  void _sortAllProducts(
      SortAllProducts event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(selectedSortOption: event.sortOption));

      // Clone the products list to avoid mutating the original list
      List<ProductModel> sortedProducts = List.from(state.allProducts);

      switch (event.sortOption) {
        case "Name":
          sortedProducts.sort((a, b) => a.title.compareTo(b.title));
          break;

        case "Higher Price":
          sortedProducts.sort((a, b) => b.price.compareTo(a.price));
          break;

        case "Lower Price":
          sortedProducts.sort((a, b) => a.price.compareTo(b.price));
          break;

        // case "Newest":
        //   sortedProducts.sort((a, b) => b.date.compareTo(a.date));
        //   break;

        case "Sale":
          sortedProducts.sort((a, b) {
            // Handle cases where salePrice might be null
            final aSalePrice = a.salePrice ?? a.price;
            final bSalePrice = b.salePrice ?? b.price;

            // Calculate discount percentages
            final aDiscountPercent = (a.price - aSalePrice) / a.price * 100;
            final bDiscountPercent = (b.price - bSalePrice) / b.price * 100;

            // Sort by discount percentage in descending order
            return bDiscountPercent.compareTo(aDiscountPercent);
          });
          break;

        default:
          // Default sorting option: Name
          sortedProducts.sort((a, b) => a.title.compareTo(b.title));
      }

      // Emit the sorted products list
      emit(state.copyWith(allProducts: sortedProducts));
    } catch (e) {
      if (kDebugMode) {
        print("Error while fetching sort products, Error: $e");
      }
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }

  // ----------Assign sort pRODUCTS --------
  void _assignSortAllProducts(
      AssignSortAllProducts event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(allProducts: event.products));
      add(SortAllProducts(sortOption: "Name", context: event.context));
    } catch (e) {
      if (kDebugMode) {
        print("Error while aSSIGN sort products, Error: $e");
      }
      SnackbarService.showError(context: event.context, message: e.toString());
    }
  }
  // ------------------------Other Methos--------------------

  void _pageChanged(PageChanged event, Emitter<ProductState> emit) {
    emit(state.copyWith(imageCurrentIndex: event.newIndex));
  }

  void _colorSelected(ColorSelected event, Emitter<ProductState> emit) {
    emit(state.copyWith(selectedColor: event.color));
  }

  void _sizeSelected(SizeSelected event, Emitter<ProductState> emit) {
    emit(state.copyWith(selectedSize: event.size));
  }

  void _quantityChanged(QuantityChanged event, Emitter<ProductState> emit) {
    emit(state.copyWith(quantity: event.quantity));
  }

  void _allEmptySelction(AllEmptySelction event, Emitter<ProductState> emit) {
    emit(state.copyWith(quantity: 1, selectedColor: '', selectedSize: ''));
  }

  void _initializeVariations(
      InitializeVariations event, Emitter<ProductState> emit) {
    final firstColor =
        event.availableColors.isNotEmpty ? event.availableColors.first : '';
    final firstSize =
        event.availableSizes.isNotEmpty ? event.availableSizes.first : '';

    emit(state.copyWith(
      selectedColor: firstColor,
      selectedSize: firstSize,
      quantity: 1,
    ));
  }
}
