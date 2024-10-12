import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/product_all/product_details/widgets/m_choice_chip.dart';

class SizeChoiceChip extends StatelessWidget {
  const SizeChoiceChip({super.key, required this.sizes});
  final List<String> sizes;

  @override
  Widget build(BuildContext context) {
    print("size chip page rebuild");
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous.selectedSize != current.selectedSize,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MSectionHeading(title: "Sizes", showActionButton: false),
            const SizedBox(height: MSizes.spaceBtwItems / 2),
            SizedBox(
              height: 41,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sizes.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final size = sizes[index];
                  return SizedBox(
                    child: MChoiceChip(
                      text: size,
                      selected: state.selectedSize == size,
                      onSelected: (value) {
                        context.read<ProductBloc>().add(SizeSelected(size));
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
