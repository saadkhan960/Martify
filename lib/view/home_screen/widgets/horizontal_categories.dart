import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Categories/categories_bloc.dart';
import 'package:martify/controller/product%20controller/all_product_controller.dart';
import 'package:martify/utils/common/styles/category_shimmer_loader.dart';
import 'package:martify/utils/common/widgets/listviewbuilder%20widgets/vertical_image_text_widget.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/All%20Products/all_products.dart';

class HorizontalCategories extends StatefulWidget {
  const HorizontalCategories({
    super.key,
  });

  @override
  State<HorizontalCategories> createState() => _HorizontalCategoriesState();
}

class _HorizontalCategoriesState extends State<HorizontalCategories> {
  @override
  void initState() {
    super.initState();
    // Fetch the categories once when the page is opened
    context.read<CategoriesBloc>().add(FetchCategories(context: context));
  }

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const MategoryShimmerLoader(count: 8);
        }
        if (state.filteredCategories.isEmpty) {
          return Center(
            child: Text(
              "No Data Found",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.white),
            ),
          );
        } else {
          return SizedBox(
              height: 80,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = state.filteredCategories[index];
                    return VerticalImageTextWidget(
                      title: category.name,
                      image: category.image,
                      onTap: () {
                        // MHelperFunctions.simpleAnimationNavigation(
                        //     context, const SubCategories());
                        MHelperFunctions.simpleAnimationNavigation(
                            context,
                            AllProducts(
                              title: category.name,
                              futureMethod: AllProductController
                                  .getAllCategoryRealtedProucts(
                                      context: context,
                                      categoryId: int.parse(category.id)),
                            ));
                      },
                    );
                  }));
        }
      },
    );
  }
}
