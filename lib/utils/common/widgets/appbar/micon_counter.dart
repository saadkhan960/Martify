import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/configs/routes/routes_name.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MiconCounter extends StatelessWidget {
  const MiconCounter({
    super.key,
    this.onPressed,
    this.iconColor,
  });
  final VoidCallback? onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.allCartItems.length != current.allCartItems.length,
      builder: (context, state) {
        return Stack(children: [
          IconButton(
            onPressed: onPressed ??
                () {
                  Navigator.pushNamed(context, RoutesName.cart);
                },
            icon: Icon(
              Icons.shopping_cart,
              color: iconColor ??
                  (dark ? MAppColors.darkModeWhite : MAppColors.black),
            ),
          ),
          if (state.allCartItems.isNotEmpty)
            Positioned(
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: MAppColors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                    child: Text(state.allCartItems.length.toString(),
                        style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: MAppColors.white, fontSizeFactor: 0.8))),
              ),
            )
        ]);
      },
    );
  }
}
