import 'package:flutter/material.dart';
import 'package:martify/Model/cart%20model/cart_item_model.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/orders/widgets/order_products.dart';

class OrderProductsSection extends StatelessWidget {
  const OrderProductsSection({super.key, required this.products});
  final List<CartItemModel> products;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 15),
      shrinkWrap: true,
      itemCount: products.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: MSizes.spacerBtwSections),
      itemBuilder: (_, index) {
        return Column(
          children: [
            OrderProducts(cartitem: products[index]),
          ],
        );
      },
    );
  }
}
