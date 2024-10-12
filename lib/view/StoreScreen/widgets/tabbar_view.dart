import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Model/category_model.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/controller/brand%20controller/brand_controller.dart';
import 'package:martify/controller/product%20controller/all_product_controller.dart';
import 'package:martify/utils/common/styles/boxes_shimmer.dart';
import 'package:martify/utils/common/styles/list_tile_shimmer.dart';
import 'package:martify/utils/common/styles/vertical_product_shimmer.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/horizontal%20card/product_card_vertical.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/cloud_helper_func.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/All%20Products/all_products.dart';
import 'package:martify/view/StoreScreen/widgets/brand_showcase.dart';

class MTabBarView extends StatelessWidget {
  const MTabBarView({
    super.key,
    this.images,
    this.padding = MSizes.defaultSpace,
    this.brandName = 'Nike',
    this.totalProducts = '256 Products',
    this.onTap,
    required this.category,
  });
  final List<String>? images;
  final double padding;
  final String brandName;
  final String totalProducts;
  final VoidCallback? onTap;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Future builder to get category related brands with limit 2
            FutureBuilder(
                future: BrandController.getBrandForCategories(
                    context: context, categoryId: category.id),
                builder: (context, snapshot) {
                  const loader = Column(children: [
                    MListTileShimmer(),
                    SizedBox(height: MSizes.spaceBtwItems),
                    MBoxesShimmer(),
                    SizedBox(height: MSizes.spaceBtwItems),
                  ]);
                  final widget = MCloudHelperFunc.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;
                  //Recored Recived!
                  final brands = snapshot.data!;
                  // listview builder to fetch brands showcase
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: brands.length,
                      itemBuilder: (_, index) {
                        final brand = brands[index];
                        // future builder for fetch images of 3 products with related brand
                        return FutureBuilder(
                          future:
                              BrandController.getBrandRelatedProductsWithLimit(
                                  brandId: int.parse(brand.id),
                                  context: context,
                                  limit: 3),
                          builder: (context, snapshot) {
                            const loader = MBoxesShimmer();
                            final widget =
                                MCloudHelperFunc.checkMultiRecordState(
                                    snapshot: snapshot, loader: loader);
                            if (widget != null) return widget;
                            //  products found
                            final product = snapshot.data!;
                            return MBrandShowcase(
                              brand: brand,
                              images: product
                                  .map(
                                    (images) => images.images.isNotEmpty &&
                                            images.images[0].isNotEmpty
                                        ? images.images[0]
                                        : MImages.noProductImage,
                                  )
                                  .toList(),
                              onTap: onTap,
                              product: product,
                            );
                          },
                        );
                      });
                }),
            const SizedBox(height: MSizes.spaceBtwItems),
            MSectionHeading(
              title: "You might like",
              buttonOnPress: () {
                MHelperFunctions.simpleAnimationNavigation(
                    context,
                    AllProducts(
                      title: category.name,
                      futureMethod:
                          AllProductController.getAllCategoryRealtedProucts(
                              context: context,
                              categoryId: int.parse(category.id)),
                    ));
              },
            ),
            const SizedBox(height: MSizes.spaceBtwItems),
            FutureBuilder(
              future: AllProductController.getCategoryRealtedProucts(
                  context: context,
                  categoryId: int.parse(category.id),
                  limit: 4),
              builder: (context, snapshot) {
                final widget = MCloudHelperFunc.checkMultiRecordState(
                    snapshot: snapshot, loader: const VerticalProductShimmer());
                if (widget != null) return widget;
                //  products found
                final product = snapshot.data!;
                return GridProductsLayout(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<ProductBloc, ProductState>(
                      buildWhen: (previous, current) => false,
                      builder: (context, state) {
                        return MProductCardVertical(
                          product: product[index],
                          brand: state.featuredBrands.firstWhere(
                            (brand) =>
                                brand.id == product[index].brand.toString(),
                            // orElse: () => null,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
