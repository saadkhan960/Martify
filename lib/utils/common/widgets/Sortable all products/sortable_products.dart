import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/styles/vertical_product_shimmer.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/horizontal%20card/product_card_vertical.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/All%20Products/widgets/drop_down_field.dart';

class MSortableProducts extends StatefulWidget {
  const MSortableProducts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<MSortableProducts> createState() => _MSortableProductsState();
}

class _MSortableProductsState extends State<MSortableProducts> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
        AssignSortAllProducts(context: context, products: widget.products));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Dropdown FIELD
        const DropDownField(),
        const SizedBox(height: MSizes.spacerBtwSections),
        //Grid Products List
        BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) =>
              previous.allProducts != current.allProducts,
          builder: (context, state) {
            if (state.isLoading) {
              return const VerticalProductShimmer();
            }
            if (state.featuredProducts.isEmpty) {
              return Center(
                  child: Text(
                "No Product Found",
                style: Theme.of(context).textTheme.bodyMedium,
              ));
            } else {
              return GridProductsLayout(
                itemCount: state.allProducts.length,
                itemBuilder: (contex, index) {
                  return MProductCardVertical(
                    product: state.allProducts[index],
                    brand: state.featuredBrands.firstWhere(
                      (brand) =>
                          brand.id == state.allProducts[index].brand.toString(),
                      // orElse: () => null,
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
