import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/controller/product%20controller/all_product_controller.dart';
import 'package:martify/utils/common/styles/vertical_product_shimmer.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';
import 'package:martify/utils/common/widgets/banner/custombanner.dart';
import 'package:martify/utils/common/widgets/curved_header/primary_header_widget.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/horizontal%20card/product_card_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/All%20Products/all_products.dart';
import 'package:martify/view/home_screen/widgets/horizontal_categories.dart';
import 'package:martify/view/home_screen/widgets/main_custom_appbar.dart';
import 'package:martify/utils/common/widgets/searchContainer/search_container_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -------Header-------------------
            MPrimaryHeaderWidget(
              child: Column(
                children: [
                  //APPBAR
                  const MainCustomAppBar(),
                  const SizedBox(height: MSizes.spacerBtwSections),
                  //SEARCHBAR
                  SearchContainerAppBar(
                    hintText: "Search in Store",
                    onTap: () {},
                  ),
                  const SizedBox(height: MSizes.spacerBtwSections),
                  //Categories
                  Padding(
                    padding: const EdgeInsets.only(left: MSizes.defaultSpace),
                    child: Column(
                      children: [
                        //Heading
                        MSectionHeading(
                            title: "Popular Categories",
                            textColor: dark
                                ? MAppColors.darkModeWhite
                                : MAppColors.white,
                            showActionButton: false),
                        const SizedBox(height: MSizes.spaceBtwItems),
                        //Categories
                        const HorizontalCategories()
                      ],
                    ),
                  ),
                  const SizedBox(height: MSizes.spacerBtwSections + 5)
                ],
              ),
            ),
            // -------Body-------------------
            Padding(
              padding: const EdgeInsets.all(MSizes.defaultSpace),
              child: Column(
                children: [
                  //Banner
                  const CustomBanner(),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  //Section Heading
                  MSectionHeading(
                    title: "Popular Products",
                    textColor:
                        dark ? MAppColors.darkModeWhite : MAppColors.black,
                    buttonTextColor:
                        dark ? MAppColors.primary : MAppColors.black,
                    showActionButton: true,
                    buttonOnPress: () {
                      MHelperFunctions.simpleAnimationNavigation(
                          context,
                          AllProducts(
                            title: "Popular Products",
                            futureMethod:
                                AllProductController.fetchAllProducts(context),
                          ));
                    },
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  //Popular Vertical Products Grid
                  BlocBuilder<ProductBloc, ProductState>(
                    buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading ||
                        previous.featuredProducts != current.featuredProducts,
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const VerticalProductShimmer();
                      }
                      if (state.featuredProducts.isEmpty) {
                        return Center(
                            child: Text(
                          "No Product Found Something Went Wrong ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ));
                      } else {
                        return GridProductsLayout(
                          itemCount: state.featuredProducts.length,
                          itemBuilder: (contex, index) {
                            return MProductCardVertical(
                              product: state.featuredProducts[index],
                              brand: state.featuredBrands.firstWhere(
                                (brand) =>
                                    brand.id ==
                                    state.featuredProducts[index].brand
                                        .toString(),
                                // orElse: () => null,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
