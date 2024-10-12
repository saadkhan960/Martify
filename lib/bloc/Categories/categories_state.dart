part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final bool isLoading;
  final List<CategoryModel> allCategories;
  final List<CategoryModel> filteredCategories;

  const CategoriesState({
    this.isLoading = false,
    this.allCategories = const <CategoryModel>[],
    this.filteredCategories = const <CategoryModel>[],
  });

  CategoriesState copyWith(
      {bool? isLoading,
      List<CategoryModel>? allCategories,
      List<CategoryModel>? filteredCategories}) {
    return CategoriesState(
        isLoading: isLoading ?? this.isLoading,
        allCategories: allCategories ?? this.allCategories,
        filteredCategories: filteredCategories ?? this.filteredCategories);
  }

  @override
  List<Object> get props => [isLoading, allCategories, filteredCategories];
}
