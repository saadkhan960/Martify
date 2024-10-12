import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:martify/Data/Category%20Repo/category_repository.dart';
import 'package:martify/Model/category_model.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  // final CategoryRepository categoryRepository = CategoryRepository();
  CategoriesBloc() : super(const CategoriesState()) {
    on<FetchCategories>(_fetchCategories);
  }

  void _fetchCategories(
      FetchCategories event, Emitter<CategoriesState> emit) async {
    if (state.allCategories.isNotEmpty) {
      // If categories are already fetched, don't fetch again
      return;
    }
    try {
      //Start Loading
      emit(state.copyWith(isLoading: true));

      //Fetch Categories from FireStore
      final categories = await CategoryRepository.saveUserRecord();

      //Update the categories List
      emit(state.copyWith(allCategories: categories));

      //Filter Featured Categories
      final filterCategories = categories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList();

      //Assign Filter Featured Categories
      emit(state.copyWith(filteredCategories: filterCategories));

      //Stop Loading
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      SnackbarService.showError(context: event.context, message: e.toString());
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
