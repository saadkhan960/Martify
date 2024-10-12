part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends CategoriesEvent {
  final BuildContext context;
  const FetchCategories({required this.context});
  @override
  List<Object> get props => [context];
}
