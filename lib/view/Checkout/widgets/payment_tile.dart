import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/payment_method_model.dart';
import 'package:martify/bloc/Checkout/checkout_bloc.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MPaymentTile extends StatelessWidget {
  const MPaymentTile(
      {super.key, required this.paymentMethod, required this.checkoutBloc});

  final PaymentMethodModel paymentMethod;
  final CheckoutBloc checkoutBloc;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        checkoutBloc.add(SelectMethod(method: paymentMethod));
        Navigator.of(context).pop();
      },
      leading: MRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: dark ? MAppColors.darkModeWhite : MAppColors.white,
        padding: const EdgeInsets.all(MSizes.sm),
        child:
            Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(
        paymentMethod.name,
        style: TextStyle(
            color: dark ? MAppColors.darkModeWhite : MAppColors.black),
      ),
      trailing: Icon(
        Iconsax.arrow_right_34,
        color: dark ? MAppColors.darkModeWhite : MAppColors.black,
      ),
    );
  }
}
