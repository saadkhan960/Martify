part of 'product_bloc.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final List<ProductModel> allProducts;
  final List<ProductModel> featuredProducts;
  final List<BrandModel> featuredBrands;
  final int imageCurrentIndex;
  final String? selectedColor;
  final String? selectedSize;
  final int quantity;
  final String selectedSortOption;

  const ProductState({
    this.selectedSortOption = 'Name',
    this.allProducts = const <ProductModel>[],
    this.featuredProducts = const <ProductModel>[],
    this.isLoading = false,
    this.featuredBrands = const <BrandModel>[],
    this.imageCurrentIndex = 0,
    this.selectedColor,
    this.selectedSize,
    this.quantity = 1,
  });

  ProductState copyWith({
    String? selectedSortOption,
    bool? isLoading,
    int? imageCurrentIndex,
    List<ProductModel>? allProducts,
    List<ProductModel>? featuredProducts,
    List<BrandModel>? featuredBrands,
    String? selectedColor,
    String? selectedSize,
    int? quantity,
  }) {
    return ProductState(
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
      allProducts: allProducts ?? this.allProducts,
      imageCurrentIndex: imageCurrentIndex ?? this.imageCurrentIndex,
      featuredBrands: featuredBrands ?? this.featuredBrands,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      isLoading: isLoading ?? this.isLoading,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        featuredProducts,
        featuredBrands,
        imageCurrentIndex,
        selectedColor,
        selectedSize,
        quantity,
        allProducts,
        selectedSortOption
      ];
}
