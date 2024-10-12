part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final BuildContext context;
  const FetchProducts({required this.context});
  @override
  List<Object> get props => [context];
}

// class FetchAllProducts extends ProductEvent {
//   final BuildContext context;
//   const FetchAllProducts({required this.context});
//   @override
//   List<Object> get props => [context];
// }
class SortAllProducts extends ProductEvent {
  final BuildContext context;
  final String sortOption;
  const SortAllProducts({required this.sortOption, required this.context});
  @override
  List<Object> get props => [context, sortOption];
}

class AssignSortAllProducts extends ProductEvent {
  final BuildContext context;
  final List<ProductModel> products;
  const AssignSortAllProducts({required this.products, required this.context});
  @override
  List<Object> get props => [context, products];
}

class PageChanged extends ProductEvent {
  final int newIndex;

  const PageChanged(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}

class ColorSelected extends ProductEvent {
  final String color;

  const ColorSelected(this.color);

  @override
  List<Object> get props => [color];
}

class SizeSelected extends ProductEvent {
  final String size;

  const SizeSelected(this.size);

  @override
  List<Object> get props => [size];
}

class QuantityChanged extends ProductEvent {
  final int quantity;

  const QuantityChanged(this.quantity);

  @override
  List<Object> get props => [quantity];
}

class AllEmptySelction extends ProductEvent {}

class InitializeVariations extends ProductEvent {
  final List<String> availableColors;
  final List<String> availableSizes;

  const InitializeVariations(
      {required this.availableColors, required this.availableSizes});

  @override
  List<Object> get props => [availableColors];
}
