import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/product_all/product_details/widgets/color_choice_chip.dart';
import 'package:martify/view/product_all/product_details/widgets/product_bottom_card.dart';
import 'package:martify/view/product_all/product_details/widgets/product_description.dart';
import 'package:martify/view/product_all/product_details/widgets/product_image_slider.dart';
import 'package:martify/view/product_all/product_details/widgets/product_meta_data.dart';
import 'package:martify/view/product_all/product_details/widgets/rating_and_share.dart';
import 'package:martify/view/product_all/product_details/widgets/size_choice_chip.dart';
import 'package:martify/view/product_all/product_reviews/product_reviews.dart';
import 'package:martify/view/product_all/product_reviews/widgets/user_review_card.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product, required this.brand});
  final ProductModel product;
  final BrandModel brand;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();
    // Reset all selections (color, size, quantity)
    context.read<ProductBloc>().add(AllEmptySelction());

    // Reset the page index
    context.read<ProductBloc>().add(const PageChanged(0));

    // Initialize the first available color and size after resetting
    context.read<ProductBloc>().add(InitializeVariations(
          availableColors:
              widget.product.colors == null ? [] : widget.product.colors!,
          availableSizes:
              widget.product.sizes == null ? [] : widget.product.sizes!,
        ));
  }

  @override
  Widget build(BuildContext context) {
    print("product detail page rebuild");
    // final dark = MHelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ProductBottomCard(
          product: widget.product,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Product Images slider
              ProductImageSlider(
                  imageLength: widget.product.images.isEmpty
                      ? 0
                      : widget.product.images.length,
                  images: widget.product.images.isEmpty
                      ? [MImages.noProductImage]
                      : widget.product.images,
                  isNetworkImage: widget.product.images.isEmpty ? false : true),
              //Product Details
              Padding(
                padding: const EdgeInsets.only(
                    right: MSizes.defaultSpace, left: MSizes.defaultSpace),
                child: Column(
                  children: [
                    //Rating and share------------
                    RatingAndShare(product: widget.product),
                    // price /title / stock / brand-----------
                    ProductMetaData(
                        product: widget.product, brand: widget.brand),
                    // Color Choice--------------
                    if (widget.product.colors != null)
                      const SizedBox(height: MSizes.spacerBtwSections),
                    if (widget.product.colors != null)
                      ColorChoiceChip(colors: widget.product.colors!),
                    // Size Choice------------
                    if (widget.product.sizes != null)
                      const SizedBox(height: MSizes.spaceBtwItems),
                    if (widget.product.sizes != null)
                      SizeChoiceChip(sizes: widget.product.sizes!),

                    // // Checkout Button--------
                    // const SizedBox(height: MSizes.spacerBtwSections),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //       onPressed: () {},
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           const Icon(Iconsax.shopping_cart),
                    //           const SizedBox(width: 5),
                    //           Text(
                    //               "Checkout \$${widget.product.getFormattedPrice()}")
                    //         ],
                    //       )),
                    // ),
                    //Description--------------
                    const SizedBox(height: MSizes.spacerBtwSections),
                    ProductDescription(
                      heading: "Description",
                      descriptonText: widget.product.description,
                    ),
                    //Reviews--------------
                    const Divider(
                      thickness: 0.5,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MSectionHeading(
                      // usewidget: IconButton(
                      //   onPressed: () {
                      //     MHelperFunctions.simpleAnimationNavigation(
                      //         context, const ProductReviews());
                      //   },
                      //   icon: const Icon(
                      //     Iconsax.arrow_right_3,
                      //     color: MAppColors.primary,
                      //   ),
                      // ),
                      title: "Reviews(139)",
                      showActionButton: true,
                      buttonOnPress: () {
                        MHelperFunctions.simpleAnimationNavigation(
                            context, const ProductReviews());
                      },
                    ),
                    const SizedBox(height: MSizes.spacerBtwSections),
                    const UserReviewCard(),
                    const UserReviewCard(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
