import 'package:flutter/material.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/bannerimages/rounded_image.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/product_card_horizontal.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';

class SubCategories extends StatelessWidget {
  const SubCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Sports",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              //Banner---------------------------
              const MRoundedImage(
                imageurl: MImages.promoBanner3,
                width: double.infinity,
                // height: ,
                applyImageRadius: true,
              ),
              const SizedBox(height: MSizes.spacerBtwSections),
              //Sub Categories-------------------
              //Heading1----------------------
              MSectionHeading(title: "Sports Shoes", buttonOnPress: () {}),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ProductCardHorizontal(
                        product: ProductModel.empty(),
                        imageUrl: MImages.productImage1,
                        discountPercentage: "25",
                        price: "256",
                        producttitle: "Air Jordan 1 Ko Chicago",
                        brandName: "Nike",
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              //Heading2-------------------
              MSectionHeading(title: "Sports Shirts", buttonOnPress: () {}),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ProductCardHorizontal(
                        product: ProductModel.empty(),
                        imageUrl: MImages.productImage55,
                        discountPercentage: "35",
                        price: "355",
                        producttitle: "Zara Simple Sports Shirt",
                        brandName: "Zara",
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
