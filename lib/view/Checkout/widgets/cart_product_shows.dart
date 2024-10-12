import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/Cart/widgets/main_cart_item.dart';

class CartProductShows extends StatelessWidget {
  const CartProductShows({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    final length = context.read<CartBloc>().state.allCartItems.length;
    return MRoundedContainer(
      borderColor: dark ? MAppColors.darkerGrey : MAppColors.grey,
      padding: const EdgeInsets.all(MSizes.sm + 3),
      showBorder: true,
      backgroundColor: dark ? MAppColors.scafoldDark : MAppColors.white,
      height: length == 2 ? 180 : (length == 1 ? 90 : 220),
      child: const MainCartItem(
        remove: false,
      ),
    );
  }
}
