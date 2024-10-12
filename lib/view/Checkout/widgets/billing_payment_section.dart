import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Checkout/checkout_bloc.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        MSectionHeading(
          title: "Payment Method",
          buttonText: "Change",
          buttonOnPress: () {
            context
                .read<CheckoutBloc>()
                .add(SelectPaymentMethod(context: context));
          },
        ),
        const SizedBox(height: MSizes.spaceBtwItems / 2),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          buildWhen: (previous, current) {
            return previous.selectedPaymentMethod !=
                current.selectedPaymentMethod;
          },
          builder: (context, state) {
            return Row(
              children: [
                MRoundedContainer(
                  width: 60,
                  height: 35,
                  backgroundColor:
                      dark ? MAppColors.darkModeWhite : MAppColors.white,
                  padding: const EdgeInsets.all(MSizes.sm),
                  child: Image(
                      image: AssetImage(state.selectedPaymentMethod.image),
                      fit: BoxFit.contain),
                ),
                const SizedBox(width: MSizes.spaceBtwItems / 2),
                Text(
                  state.selectedPaymentMethod.name,
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                      color:
                          dark ? MAppColors.darkModeWhite : MAppColors.black),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
