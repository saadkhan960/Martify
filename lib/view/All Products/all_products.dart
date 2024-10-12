import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/controller/product%20controller/all_product_controller.dart';
import 'package:martify/utils/common/styles/vertical_product_shimmer.dart';
import 'package:martify/utils/common/widgets/Sortable%20all%20products/sortable_products.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/cloud_helper_func.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: FutureBuilder(
                future: futureMethod ??
                    AllProductController.fetchProductsByQuery(query, context),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const VerticalProductShimmer();
                  // }
                  // if (!snapshot.hasData ||
                  //     snapshot.data == null ||
                  //     snapshot.data!.isEmpty) {
                  //   return const Center(child: Text("No Data Found!"));
                  // }
                  // if (snapshot.hasError) {
                  //   return const Center(child: Text("Something Went Wrong!"));
                  // }
                  final widget = MCloudHelperFunc.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: const VerticalProductShimmer(),
                  );

                  if (widget != null) return widget;

                  final products =
                      snapshot.data ?? []; // Default to empty list if null

                  return MSortableProducts(
                    products: products,
                  );
                })),
      ),
    );
  }
}
