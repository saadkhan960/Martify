import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/popups/custom_dialog.dart';
import 'package:martify/view/Cart/widgets/main_cart_item.dart';
import 'package:martify/view/Checkout/checkout.dart';

class Cart extends StatelessWidget {
  const Cart({super.key, required this.cartinhome});
  final bool cartinhome;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: CustomAppBar(
            title: Text(
              "Cart",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            showBackArrow: cartinhome ? false : true,
            actions: [
              BlocBuilder<CartBloc, CartState>(
                buildWhen: (previous, current) =>
                    previous.allCartItems != current.allCartItems,
                builder: (context, state) {
                  if (state.allCartItems.isEmpty) {
                    return const SizedBox();
                  }
                  return IconButton(
                      onPressed: () {
                        MCustomDialog.showCustomDialog(
                            context: context,
                            titleText: "Remove Cart Products",
                            deleteButtonText: "Remove",
                            cancelButtonText: "No",
                            onCancle: () {
                              Navigator.of(context).pop();
                            },
                            contentText:
                                "Are you sure you want to remove all items from your cart? This action cannot be undone.",
                            onDelete: () {
                              context.read<CartBloc>().add(ClearCart());
                              Navigator.of(context).pop();
                            });
                      },
                      icon: const Icon(
                        Icons.delete_sweep_rounded,
                        size: 30,
                      ));
                },
              )
            ]),
        body: const MainCartItem(),
      ),
      Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) =>
                previous.allCartItems != current.allCartItems ||
                previous.cartItems != current.cartItems,
            builder: (context, state) {
              if (state.allCartItems.isEmpty) {
                return const SizedBox();
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: MSizes.md, right: MSizes.md, bottom: MSizes.md),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<CartBloc, CartState>(
                      buildWhen: (previous, current) =>
                          previous.allCartItems != current.allCartItems ||
                          previous.cartItems != current.cartItems,
                      builder: (context, state) {
                        final totalAmount =
                            MHelperFunctions.calculateTotalAmount(
                                state.cartItems);
                        return ElevatedButton(
                            onPressed: () {
                              MHelperFunctions.simpleAnimationNavigation(
                                  context, const Checkout());
                            },
                            child: Text("Checkout (\$$totalAmount)"));
                      },
                    ),
                  ),
                ),
              );
            },
          ))
    ]);
  }
}
