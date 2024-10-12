import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/product_all/product_details/widgets/m_choice_chip.dart';

class ColorChoiceChip extends StatelessWidget {
  const ColorChoiceChip({super.key, required this.colors});
  final List<String> colors;

  @override
  Widget build(BuildContext context) {
    print("color chip page rebuild");
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous.selectedColor != current.selectedColor,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MSectionHeading(title: "Colors", showActionButton: false),
            const SizedBox(height: MSizes.spaceBtwItems / 2),
            SizedBox(
              height: 41,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final color = colors[index];
                  return SizedBox(
                    child: MChoiceChip(
                      text: color,
                      selected: state.selectedColor == color,
                      onSelected: (value) {
                        context.read<ProductBloc>().add(ColorSelected(color));
                      },
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
