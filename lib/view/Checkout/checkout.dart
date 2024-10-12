import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Addresses/address_bloc.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/bloc/Checkout/checkout_bloc.dart';
import 'package:martify/bloc/Order/order_bloc.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/Checkout/widgets/billing_address_section.dart';
import 'package:martify/view/Checkout/widgets/billing_amount_section.dart';
import 'package:martify/view/Checkout/widgets/billing_payment_section.dart';
import 'package:martify/view/Checkout/widgets/cart_product_shows.dart';
import 'package:martify/view/Checkout/widgets/coupons_code.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(AllUserAddresses());
    context.read<CheckoutBloc>().add(CalculateTotalAmount(context: context));
  }

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            children: [
              //Section Heading---------
              BlocBuilder<CartBloc, CartState>(
                buildWhen: (previous, current) =>
                    previous.allCartItems != current.allCartItems ||
                    previous.cartItems != current.cartItems,
                builder: (context, state) {
                  return MSectionHeading(
                    title: "Total Products",
                    usewidget: Text(
                      state.allCartItems.length.toString(),
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                          color: dark
                              ? MAppColors.darkModeWhite
                              : MAppColors.black),
                    ),
                  );
                },
              ),
              const SizedBox(height: MSizes.spaceBtwItems),
              //Cart Items Shows---------
              const CartProductShows(),
              const SizedBox(height: MSizes.spacerBtwSections),
              //Coupon Textfield-----------
              const MCouponCode(),
              const SizedBox(height: MSizes.spacerBtwSections),
              //Billing Section-----------
              MRoundedContainer(
                borderColor: dark ? MAppColors.darkerGrey : MAppColors.grey,
                padding: const EdgeInsets.all(MSizes.md),
                showBorder: true,
                backgroundColor: dark ? MAppColors.black : MAppColors.white,
                child: Column(
                  children: [
                    //Pricing
                    const BillingAmountSection(),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Divider
                    Divider(
                      color: dark ? MAppColors.darkerGrey : MAppColors.grey,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Payment Methods
                    const BillingPaymentSection(),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    //Divider
                    Divider(
                      color: dark ? MAppColors.darkerGrey : MAppColors.grey,
                    ),
                    //Address
                    const BillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      //Bottom CheckOut Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            left: MSizes.md, right: MSizes.md, bottom: MSizes.md),
        child: ElevatedButton(
            onPressed: () {
              // MHelperFunctions.simpleAnimationNavigation(
              //     context, const OrderSuccessScreen());
              context.read<OrderBloc>().add(AddOrder(context: context));
            },
            child: Text(
                "Place Order (\$${context.watch<CheckoutBloc>().state.orderTotal})")),
      ),
    );
  }
}
