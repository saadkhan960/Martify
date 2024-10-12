import 'package:flutter/material.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/controller/brand%20controller/brand_controller.dart';
import 'package:martify/utils/common/styles/vertical_product_shimmer.dart';
import 'package:martify/utils/common/widgets/Sortable%20all%20products/sortable_products.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/StoreScreen/widgets/mbrand_card.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          brand.name.toString(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Column(
              children: [
                MBrandCard(
                  showBorder: true,
                  brandName: brand.name.toString(),
                  image: brand.image.toString(),
                  totalProducts: brand.productCount.toString(),
                ),
                const SizedBox(height: MSizes.spacerBtwSections),
                FutureBuilder(
                  future: BrandController.getBrandRelatedProducts(
                      context: context, brandId: int.parse(brand.id)),
                  builder: (context, snapshot) {
                    // MCloudHelperFunc.checkMultiRecordState(
                    //     snapshot: snapshot,
                    //     loader: const VerticalProductShimmer());
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const VerticalProductShimmer();
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'No Product Found!',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ));
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong.'));
                    }

                    final product = snapshot.data;
                    return MSortableProducts(
                      products: product ?? [],
                    );
                  },
                )
              ],
            )),
      ),
    );
  }
}
