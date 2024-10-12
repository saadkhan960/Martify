import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/cart%20model/cart_item_model.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/utils/common/widgets/icons/circularicon.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MProductQuantityWithAddRemoveButton extends StatelessWidget {
  const MProductQuantityWithAddRemoveButton({
    super.key,
    required this.cartitem,
  });
  final CartItemModel cartitem;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) =>
                  previous.allCartItems != current.allCartItems,
              builder: (context, state) {
                return MCircularIcon(
                  icon: Iconsax.minus,
                  width: 32,
                  height: 32,
                  size: MSizes.md,
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black,
                  backgroundColor: dark
                      ? MAppColors.darkerGrey
                      : MAppColors.light.withOpacity(0.9),
                  onPressed: () => context.read<CartBloc>().add(
                      AddQuantityInCart(
                          productId: cartitem.productId,
                          size: cartitem.size,
                          color: cartitem.color,
                          addfunction: false)),
                );
              },
            ),
            const SizedBox(width: MSizes.spaceBtwItems),
            Text(cartitem.quantity.toString(),
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: MSizes.spaceBtwItems),
            BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) =>
                  previous.allCartItems != current.allCartItems,
              builder: (context, state) {
                return MCircularIcon(
                  icon: Iconsax.add,
                  width: 32,
                  height: 32,
                  size: MSizes.md,
                  color: MAppColors.white,
                  backgroundColor: MAppColors.primary,
                  onPressed: () => context.read<CartBloc>().add(
                      AddQuantityInCart(
                          productId: cartitem.productId,
                          size: cartitem.size,
                          color: cartitem.color,
                          addfunction: true)),
                );
              },
            )
          ],
        );
      },
    );
  }
}
