import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/utils/common/widgets/Image%20With%20Text/image_with_text.dart';
import 'package:martify/utils/common/widgets/products/extra%20widgets/productpricetext.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/popups/custom_dialog.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';
import 'package:martify/view/Cart/widgets/cart_item.dart';
import 'package:martify/view/Cart/widgets/product_quantity_add_remove.dart';

class MainCartItem extends StatelessWidget {
  const MainCartItem({super.key, this.remove = true});
  final bool remove;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.allCartItems != current.allCartItems ||
          previous.cartItems != current.cartItems,
      builder: (context, state) {
        if (state.allCartItems.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(MSizes.defaultSpace),
            child: ImageWithText(
              imageColor: false,
              image: "assets/images/empty_cart.png",
              title: "Your cart is empty!",
              secondTile: "Add some items to get started!",
            ),
          );
        }
        return Padding(
          padding: remove
              ? const EdgeInsets.only(
                  left: MSizes.defaultSpace,
                  right: MSizes.defaultSpace,
                  bottom: MSizes.defaultSpace,
                  top: 5,
                )
              : const EdgeInsets.all(0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              padding: remove ? const EdgeInsets.only(bottom: 80) : null,
              shrinkWrap: true,
              itemCount: state.allCartItems.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: MSizes.spacerBtwSections),
              itemBuilder: (_, index) {
                final cartitem = state.allCartItems[index];
                if (remove) {
                  return Dismissible(
                    key: Key(cartitem.productId),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete,
                          color: Colors.white), // Delete icon
                    ),
                    confirmDismiss: (direction) async {
                      // Show a confirmation dialog before deleting
                      return await MCustomDialog.cartCustomDialog(
                        context: context,
                        titleText: 'Confirm Remove',
                        contentText:
                            'Are you sure you want to remove ${cartitem.title} from the cart?',
                      );
                    },
                    onDismissed: (direction) {
                      // If user confirmed deletion
                      context.read<CartBloc>().add(RemoveCartItem(
                          productId: cartitem.productId,
                          size: cartitem.size,
                          color: cartitem.color));

                      // Show a snackbar when the item is deleted
                      SnackbarService.showSimpleMessage(
                          context: context,
                          message: 'Product removed from cart');
                    },
                    child: Column(
                      children: [
                        // Cart Item
                        MCartItem(cartitem: cartitem),
                        if (cartitem.color.isNotEmpty ||
                            cartitem.size.isNotEmpty)
                          const SizedBox(height: MSizes.spaceBtwItems),

                        // Quantity Add or Remove Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const SizedBox(width: 70),
                              MProductQuantityWithAddRemoveButton(
                                cartitem: cartitem,
                              ),
                            ]),
                            MProductPriceText(price: cartitem.price.toString()),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      // Cart Item
                      MCartItem(cartitem: cartitem),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
