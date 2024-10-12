import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Categories/categories_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/appbar/micon_counter.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/searchContainer/search_container_appbar.dart';
import 'package:martify/utils/common/widgets/tabbar/custom_tabbar.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/All%20Brands/all_brands.dart';
import 'package:martify/view/All%20Brands/brand_products.dart';
import 'package:martify/view/StoreScreen/widgets/mbrand_card.dart';
import 'package:martify/view/StoreScreen/widgets/tabbar_view.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    final categories = BlocProvider.of<CategoriesBloc>(context);

    return DefaultTabController(
      length: categories.state.filteredCategories.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: dark ? MAppColors.darkModeWhite : MAppColors.black),
          ),
          actions: const [MiconCounter()],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: dark ? MAppColors.black : MAppColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(MSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // Search Bar---------
                        const SizedBox(height: MSizes.spaceBtwItems),
                        SearchContainerAppBar(
                          hintText: "Search in store",
                          onTap: () {},
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: MSizes.spacerBtwSections),
                        // Heading or button------
                        MSectionHeading(
                          title: "Featured Brands",
                          showActionButton: true,
                          buttonOnPress: () {
                            MHelperFunctions.simpleAnimationNavigation(
                                context, const AllBrands());
                          },
                        ),
                        const SizedBox(height: MSizes.spaceBtwItems / 1.5),
                        //Grid View
                        BlocBuilder<ProductBloc, ProductState>(
                          buildWhen: (previous, current) =>
                              previous.featuredBrands != current.featuredBrands,
                          builder: (context, state) {
                            return GridProductsLayout(
                              mainAxisExtent: 73,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                if (state.isLoading) {
                                  return const MShimmerLoader(
                                      width: 300, height: 80);
                                }
                                if (state.featuredBrands.isEmpty) {
                                  return Center(
                                    child: Text(
                                      "No Data Found",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .apply(color: MAppColors.white),
                                    ),
                                  );
                                } else {
                                  return MBrandCard(
                                    showBorder: true,
                                    image: state.featuredBrands[index].image,
                                    brandName: state.featuredBrands[index].name,
                                    totalProducts: state
                                        .featuredBrands[index].productCount
                                        .toString(),
                                    onTap: () {
                                      MHelperFunctions
                                          .simpleAnimationNavigation(
                                              context,
                                              BrandProducts(
                                                brand:
                                                    state.featuredBrands[index],
                                              ));
                                    },
                                  );
                                }
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  //Tabs
                  bottom: CustomTabBar(
                      tabs: categories.state.filteredCategories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList()),
                )
              ];
            },
            body: TabBarView(
                children: categories.state.filteredCategories
                    .map((category) => MTabBarView(
                          category: category,
                        ))
                    .toList())),
      ),
    );
  }
}
