import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/Wishlist%20Bloc/wishlist_bloc.dart';
import 'package:martify/utils/common/widgets/icons/circularicon.dart';
import 'package:martify/utils/constants/color.dart';

class FavIcon extends StatelessWidget {
  const FavIcon(
      {super.key, this.backgroundColor = true, required this.productId});
  final bool backgroundColor;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      buildWhen: (previous, current) => previous.favorites != current.favorites,
      builder: (context, state) {
        final bool isFav = state.favorites[productId] ?? false;
        return MCircularIcon(
            backgroundColor: backgroundColor ? null : Colors.transparent,
            height: 40,
            width: 40,
            icon: isFav ? Iconsax.heart5 : Iconsax.heart,
            color: isFav ? MAppColors.red : MAppColors.grey,
            onPressed: () => context
                .read<WishlistBloc>()
                .add(ToggleFavProduct(context: context, productId: productId)));
      },
    );
  }
}
