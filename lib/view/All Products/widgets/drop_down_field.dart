import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class DropDownField extends StatelessWidget {
  const DropDownField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous.selectedSortOption != current.selectedSortOption,
      builder: (context, state) {
        return DropdownButtonFormField(
          dropdownColor: dark ? MAppColors.dark : MAppColors.light,
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.sort),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: MAppColors.darkGrey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: MAppColors.darkGrey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: MAppColors.darkGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: MAppColors.darkGrey),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: MAppColors.darkGrey),
              )),
          hint: Text(
            'Filter',
            style: TextStyle(
              color: dark ? MAppColors.darkModeWhite : MAppColors.black,
            ),
          ),
          items: ["Name", "Higher Price", "Lower Price", "Sale"].map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(
                option,
                style: TextStyle(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black,
                ),
              ),
              onTap: () {},
            );
          }).toList(),
          value: state.selectedSortOption,
          onChanged: (value) {
            context
                .read<ProductBloc>()
                .add(SortAllProducts(sortOption: value!, context: context));
          },
        );
      },
    );
  }
}
