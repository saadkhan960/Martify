import 'package:flutter/material.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/common/widgets/bannerimages/rounded_image.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/All%20Brands/brand_products.dart';
import 'package:martify/view/StoreScreen/widgets/mbrand_card.dart';
import 'package:martify/view/product_all/product_details/product_details.dart';

class MBrandShowcase extends StatelessWidget {
  const MBrandShowcase({
    super.key,
    required this.images,
    this.onTap,
    required this.brand,
    required this.product,
  });
  final List<String> images;
  final VoidCallback? onTap;
  final BrandModel brand;
  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    return MRoundedContainer(
      padding: const EdgeInsets.symmetric(vertical: MSizes.md),
      showBorder: true,
      borderColor: MAppColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: MSizes.spaceBtwItems),
      child: Column(
        children: [
          //Brand With product Count
          InkWell(
            onTap: () => MHelperFunctions.simpleNavigation(
                context, BrandProducts(brand: brand)),
            child: MBrandCard(
              showBorder: false,
              brandName: brand.name,
              totalProducts: "${brand.productCount}",
              image: brand.image,
              onTap: onTap,
            ),
          ),

          //Brand With product Count
          SizedBox(
            height: 100,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: product.length,
              separatorBuilder: (_, __) =>
                  Center(child: SizedBox(width: product.length == 3 ? 5 : 20)),
              itemBuilder: (_, index) {
                final products = product[index];
                final image = images[index];
                return brandTopProductImagesWidget(
                    brand: brand,
                    product: products,
                    image: image,
                    context: context);
              },
            ),
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: images
          //       .map((images) => brandTopProductImagesWidget(
          //           brand: brand,
          //           product: product,
          //           image: images,
          //           context: context))
          //       .toList(),
          // )
        ],
      ),
    );
  }
}

Widget brandTopProductImagesWidget(
    {required String image,
    required BuildContext context,
    bool isNetworkImage = true,
    required BrandModel brand,
    required ProductModel product}) {
  final bool isNetworkImage = Uri.tryParse(image)?.hasAbsolutePath ?? false;
  return InkWell(
    onTap: () {
      MHelperFunctions.simpleAnimationNavigation(
          context, ProductDetails(product: product, brand: brand));
    },
    child: MRoundedImage(
      height: 100,
      width: 100,
      imageurl: image,
      isNetworkImage: isNetworkImage,
      fit: BoxFit.cover,
    ),
  );
}
