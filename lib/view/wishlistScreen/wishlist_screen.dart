import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/bloc/Wishlist%20Bloc/wishlist_bloc.dart';
import 'package:martify/bloc/bottom_navbar/bottom_navbar_bloc.dart';
import 'package:martify/utils/common/widgets/Image%20With%20Text/image_with_text.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/icons/circularicon.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/horizontal%20card/product_card_vertical.dart';
import 'package:martify/utils/constants/sizes.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late List<BrandModel> brand;
  @override
  void initState() {
    super.initState();

    brand = context.read<ProductBloc>().state.featuredBrands;
    context.read<WishlistBloc>().add(FetchFavProducts(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
            buildWhen: (previous, current) => false,
            builder: (context, state) {
              return MCircularIcon(
                icon: Iconsax.add,
                onPressed: () {
                  // Navigator.pushNamed(context, RoutesName.store);
                  context
                      .read<BottomNavbarBloc>()
                      .add(const ChangeMenu(index: 0));
                },
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              BlocBuilder<WishlistBloc, WishlistState>(
                buildWhen: (previous, current) =>
                    previous.favorites != current.favorites ||
                    previous.allProducts != current.allProducts,
                builder: (context, state) {
                  if (state.favorites.isEmpty) {
                    return const ImageWithText(
                        imageColor: false,
                        image: "assets/images/empty-wishlist.png",
                        title: "Your Wishlist Is Empty");
                  }
                  if (state.allProducts.isEmpty) {
                    return const ImageWithText(
                        imageColor: false,
                        image: "assets/images/empty-wishlist.png",
                        title: "Your Wishlist Is Empty");
                  }
                  return GridProductsLayout(
                    itemCount: state.allProducts.length,
                    itemBuilder: (context, index) {
                      return MProductCardVertical(
                          product: state.allProducts[index],
                          brand: brand.firstWhere(
                            (brand) =>
                                brand.id ==
                                state.allProducts[index].brand.toString(),
                          ));
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
