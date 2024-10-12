import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/styles/brand_shimmer.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/All%20Brands/brand_products.dart';
import 'package:martify/view/StoreScreen/widgets/mbrand_card.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar------------
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "All Brands",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              // Section Heading----------------
              const MSectionHeading(
                title: "Brands",
                showActionButton: false,
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              //GridViewBuilder
              BlocBuilder<ProductBloc, ProductState>(
                buildWhen: (previous, current) =>
                    previous.featuredBrands != current.featuredBrands,
                builder: (context, state) {
                  return GridProductsLayout(
                    mainAxisExtent: 75,
                    itemCount: state.featuredBrands.length,
                    itemBuilder: (context, index) {
                      if (state.isLoading) {
                        return const MBrandShimmer();
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
                            MHelperFunctions.simpleAnimationNavigation(
                                context,
                                BrandProducts(
                                  brand: state.featuredBrands[index],
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
      ),
    );
  }
}
